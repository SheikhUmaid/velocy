import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/local_storage/secure_storage.dart';
import 'package:velocy_user_app/view/auth_page/model/user_model.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_api_provider.dart';

import '../model/profile_model.dart';

class AuthRepository {
  final Env env;
  final ApiProvider apiProvider;
  late final AuthApiProvider authApiProvider;

  AuthRepository({required this.apiProvider, required this.env}) {
    authApiProvider = AuthApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
    );
  }

  String _accessToken = '';
  String _refreshToken = '';

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  final ValueNotifier<bool> _isLoggedIn = ValueNotifier(false);
  ValueNotifier<bool> get isLoggedIn => _isLoggedIn;

  final ValueNotifier<UserModel?> _user = ValueNotifier(null);
  ValueNotifier<UserModel?> get user => _user;

  final ValueNotifier<String?> _rememberUserId = ValueNotifier(null);
  ValueNotifier<String?> get rememberUserId => _rememberUserId;

  final ValueNotifier<String> _userRole = ValueNotifier('');
  ValueNotifier<String> get userRole => _userRole;

  Future<void> initial() async {
    await fetchAccessToken();
    _user.value = await SecureStorage().getUser();
    _userRole.value = _user.value?.user.role ?? '';
  }

  Future<void> setAccessToken(String token) async {
    try {
      await SecureStorage().setAccessToken(token);
      _accessToken = token;
      _isLoggedIn.value = true;
    } catch (e) {
      debugPrint('Set AccessToken Error: $e');
    }
  }

  Future<void> setRefreshToken(String refreshToken) async {
    try {
      await SecureStorage().setRefreshToken(refreshToken);
      _refreshToken = refreshToken;
    } catch (e) {
      debugPrint('Set RefreshToken Error: $e');
    }
  }

  Future<String> fetchAccessToken() async {
    try {
      final token = await SecureStorage().getAccessToken();
      if (token != null && token.isNotEmpty) {
        _accessToken = token;
        _isLoggedIn.value = true;
        return token;
      }
    } catch (e) {
      debugPrint('Fetch AccessToken Error: $e');
    }
    return '';
  }

  Future<DataResponse> logout() async {
    try {
      final body = {"platform": Platform.isAndroid ? "android" : "ios"};

      await authApiProvider.logout(body: body, token: _accessToken);
      await _clearSession();
      return DataResponse.success(true);
    } catch (e) {
      await _clearSession();
      return DataResponse.success(true);
    }
  }

  Future<DataResponse> localLogout() async {
    try {
      await _clearSession();
      return DataResponse.success(true);
    } catch (e) {
      debugPrint('Local Logout Error: $e');
      return DataResponse.success(true);
    }
  }

  Future<void> _clearSession() async {
    await SecureStorage().removeAccessToken();
    await SecureStorage().removeRefreshToken();
    await SecureStorage().removeUser();
    _isLoggedIn.value = false;
    _user.value = null;
    _accessToken = '';
    _refreshToken = '';
  }

  Future<DataResponse<String>> login({
    required String phoneNumber,
    required String password,
  }) async {try {
      final body = {
        "phone_number": phoneNumber,
        "otp": password,
      };

      final res = await authApiProvider.login(body: body);

      _accessToken = res['data']?['access'] ?? '';
      _refreshToken = res['data']?['refresh'] ?? '';
      debugPrint("✅ Access Token: $_accessToken");

      _user.value = UserModel.fromMap(res['data'] ?? {});
      _userRole.value = _user.value?.user.role ?? '';

      await SecureStorage().setUser(user: _user.value!);
      await setAccessToken(_accessToken);
      await setRefreshToken(_refreshToken);

      return DataResponse.success(_userRole.value);
    } catch (e) {
      debugPrint('Login Error: $e');
      await _clearSession();
      return DataResponse.error(e.toString());
    }
  }
  Future<DataResponse<bool>> register({
    required String phoneNumber,
    required String password,
    required String confirmpassword,
    required String otp,
  }) async {
    try {
      final body = {
        "phone_number": phoneNumber,
        "password": password,
        "confirm_password": confirmpassword,
        "otp": otp,
      };

      final res = await authApiProvider.register(body: body);

      // Parse tokens if available (optional)
      _accessToken = res['data']?['access'] ?? '';
      _refreshToken = res['data']?['refresh'] ?? '';

      // ✅ Get and store user_id from register response
      final userId = res['data']?['user_id'];
      if (userId != null) {
        await SecureStorage().setUserId(userId.toString());
        _rememberUserId.value = userId.toString();
        debugPrint("✅ Registered User ID: $userId");
      } else {
        debugPrint("⚠️ No user_id found in registration response.");
      }

      // Save tokens
      await setAccessToken(_accessToken);
      await setRefreshToken(_refreshToken);

      return DataResponse.success(true);
    } catch (e) {
      debugPrint('Register Error: $e');
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> profileUpdate({
    required File profile,
    required String username,
    required String gender,
    required String street,
    required String area,
    required File aadharCard,
    required String addressType,
  }) async {
    try {
      final userId = await SecureStorage().getUserId();
      debugPrint('📦 Profile Update for User ID: $userId');

      final formDataMap = {
        "user_id": userId,
        "username": username,
        "gender": gender.toLowerCase(),
        "street": street,
        "area": area,
        "address_type": addressType,
        "profile": await MultipartFile.fromFile(profile.path, filename: "profile.jpg"),
      };
      if (aadharCard.path.isNotEmpty) {
        formDataMap["aadhar_card"] = await MultipartFile.fromFile(aadharCard.path, filename: "aadhar.jpg");
      }
      final formData = FormData.fromMap(formDataMap);

      final res = await authApiProvider.updateProfile(body: formData, token: _accessToken);

      // ✅ Store profile data from response
      if (res != null && res['user'] != null) {
        final profileModel = ProfileModel.fromMap(res['user']);
        await SecureStorage().setUserProfile(profileModel);
      }

      return DataResponse.success(true);
    } catch (e) {
      debugPrint('❌ Profile Update Error: $e');
      return DataResponse.error(e.toString());
    }
  }


}
