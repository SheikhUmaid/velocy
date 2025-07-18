import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:velocy_user_app/utils/custom_toast.dart';
import 'package:velocy_user_app/view/auth_page/model/user_model.dart';

import '../../view/auth_page/model/profile_model.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();

  factory SecureStorage() => _instance;

  SecureStorage._internal();

  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";
  static const String userData = "userData";
  static const String userIdKey = "userId";
  static const String userRoleKey = "userRole";

  static final FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage(
    aOptions: Platform.isAndroid
        ? const AndroidOptions(encryptedSharedPreferences: true)
        : AndroidOptions.defaultOptions,
  );

  Future<void> setAccessToken(String value) async {
    try {
      await _flutterSecureStorage.write(key: accessToken, value: value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> getAccessToken() async {
    try {
      return await _flutterSecureStorage.read(key: accessToken) ?? "";
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  Future<void> removeAccessToken() async {
    try {
      await _flutterSecureStorage.delete(key: accessToken);
    } catch (e) {
      debugPrint(e.toString());
      CustomToast.error(message: e.toString());
    }
  }

  Future<void> setRefreshToken(String value) async {
    try {
      await _flutterSecureStorage.write(key: refreshToken, value: value);
    } catch (e) {
      debugPrint(e.toString());
      CustomToast.error(message: e.toString());
    }
  }

  Future<String> getRefreshToken() async {
    try {
      return await _flutterSecureStorage.read(key: refreshToken) ?? "";
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  Future<void> removeRefreshToken() async {
    try {
      await _flutterSecureStorage.delete(key: refreshToken);
    } catch (e) {
      debugPrint(e.toString());
      CustomToast.error(message: e.toString());
    }
  }

  Future<void> setUserRole(String role) async {
    await _flutterSecureStorage.write(key: userRoleKey, value: role);
  }

  Future<String> getUserRole() async {
    return await _flutterSecureStorage.read(key: userRoleKey) ?? '';
  }

  Future<void> setUser({required UserModel user}) async {
    await _flutterSecureStorage.write(
      key: userData,
      value: jsonEncode(user.toMap()),
    );
  }

  Future<UserModel?> getUser() async {
    try {
      final data = await _flutterSecureStorage.read(key: userData);
      if (data == null || data.isEmpty) return null;
      return UserModel.fromMap(jsonDecode(data));
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> removeUser() async {
    await _flutterSecureStorage.delete(key: userData);
  }

  Future<void> setUserId(String id) async {
    try {
      await _flutterSecureStorage.write(key: userIdKey, value: id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> getUserId() async {
    try {
      return await _flutterSecureStorage.read(key: userIdKey) ?? "";
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  Future<void> removeUserId() async {
    try {
      await _flutterSecureStorage.delete(key: userIdKey);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> setUserProfile(ProfileModel profile) async {
    await _flutterSecureStorage.write(
      key: "userProfile",
      value: jsonEncode(profile.toMap()),
    );
  }

  Future<ProfileModel?> getUserProfile() async {
    final data = await _flutterSecureStorage.read(key: "userProfile");
    if (data == null) return null;
    return ProfileModel.fromMap(jsonDecode(data));
  }

  Future<void> logout() async {
    try {
      await removeAccessToken();
      await removeRefreshToken();
      await removeUser();
      await removeUserId();
      await _flutterSecureStorage.delete(key: "userProfile");
      await _flutterSecureStorage.delete(key: userRoleKey);
      CustomToast.success(message: "Logout successful");
    } catch (e) {
      debugPrint("Logout Error: $e");
      CustomToast.error(message: "Logout failed");
    }
  }

}
