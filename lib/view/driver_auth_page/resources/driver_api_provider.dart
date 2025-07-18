import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';

class DriverAuthProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  DriverAuthProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> driverRegister({
    required Map<String, String> body,
    token,
  }) async {
    final uri = "$baseUrl/auth_api/driver-registration/";

    return await apiProvider.post(uri, body, token: authRepository.accessToken);
  }

  Future<dynamic> driverDocumentUploads({required FormData body}) async {
    final uri = "$baseUrl/auth_api/document-upload/";

    return await apiProvider.post(uri, body, token: authRepository.accessToken);
  }

  Future<dynamic> becomeDriver({required FormData body}) async {
    final uri = "$baseUrl/auth_api/become-driver/";
    return await apiProvider.post(uri, body, token: authRepository.accessToken);
  }

  Future<dynamic> driverOnlineStatus({required FormData body}) async {
    final uri = "$baseUrl/driver/toggle-online/";
    return await apiProvider.post(uri, body, token: authRepository.accessToken);
  }

  Future<dynamic> driverCashLimits({String? token}) async {
    final uri = Uri.parse("$baseUrl/driver/cash-limit/");
    return await apiProvider.get(uri, token: authRepository.accessToken);
  }

  Future<dynamic> driverTotalEarning({String? token}) async {
    final uri = Uri.parse("$baseUrl/driver/driver-earnings/");
    return await apiProvider.get(uri, token: authRepository.accessToken);
  }

  Future<dynamic> driverTodaysEarning({String? token}) async {
    final uri = Uri.parse("$baseUrl/driver/today-earnings/");
    print(" Token ----${token}");
    return await apiProvider.get(uri, token: authRepository.accessToken);
  }

  Future<dynamic> driverRides({required FormData body}) async {
    final uri = "$baseUrl/driver/available-now-rides/";
    return await apiProvider.post(uri, body, token: authRepository.accessToken);
  }

  Future<dynamic> driverScheduledRides({required FormData body}) async {
    final uri = "$baseUrl/driver/available-scheduled-rides/";
    return await apiProvider.post(uri, body, token: authRepository.accessToken);
  }

  Future<dynamic> rideDetails(int id) async {
    final uri = Uri.parse("$baseUrl/driver/ride-details/$id/");
    return await apiProvider.get(uri, token: authRepository.accessToken);
  }

  Future<dynamic> driverAcceptRide(int id) async {
    final uri = "$baseUrl/driver/accept-ride/$id/";
    return await apiProvider.post(uri, {}, token: authRepository.accessToken);
  }

  Future<dynamic> driverDeclineRide({required FormData body}) async {
    final uri = "$baseUrl/driver/decline-ride/";
    return await apiProvider.post(uri, body, token: authRepository.accessToken);
  }

  Future<dynamic> driverCancelRide(int id) async {
    final uri = "$baseUrl/driver/cancel-ride/$id/";
    return await apiProvider.post(uri, {}, token: authRepository.accessToken);
  }

  Future<dynamic> driverBeginRide(int id) async {
    final uri = "$baseUrl/driver/begin-ride/$id/";
    return await apiProvider.post(uri, {}, token: authRepository.accessToken);
  }

  Future<dynamic> driverCompleteRide(int id) async {
    final uri = "$baseUrl/driver/complete-ride/$id/";
    return await apiProvider.post(uri, {}, token: authRepository.accessToken);
  }

  Future<dynamic> driverGenrateOtp(int id) async {
    final uri = "$baseUrl/driver/generate-otp/$id/";
    return await apiProvider.post(uri, {}, token: authRepository.accessToken);
  }

  Future<dynamic> driverVerifyOtp(int id) async {
    final uri = "$baseUrl/driver/verify-otp/$id/";
    return await apiProvider.post(uri, {}, token: authRepository.accessToken);
  }

  Future<dynamic> driverProfile() async {
    final uri = Uri.parse("$baseUrl/driver/driver-setting/");
    return await apiProvider.get(uri, token: authRepository.accessToken);
  }

  Future<dynamic> driverVehiclesDoc() async {
    final uri = Uri.parse("$baseUrl/driver/preview-docs/");
    return await apiProvider.get(uri, token: authRepository.accessToken);
  }
}
