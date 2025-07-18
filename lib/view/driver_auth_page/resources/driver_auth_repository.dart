import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/local_storage/secure_storage.dart';
import 'package:velocy_user_app/view/auth_page/model/profile_model.dart';
import 'package:velocy_user_app/view/auth_page/model/user_model.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/driver_auth_page/resources/driver_api_provider.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/model/driver_todays_earning_model.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/model/driver_total_earning_model.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/model/driver_settings_model.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/model/driver_vechiles_doc_model.dart';
import '../../module/driver/driver_home_page/model/cash_limit_model.dart';
import '../../module/driver/driver_home_page/model/driver_rides_model.dart';
import '../../module/driver/recent_rides_page/model/ride_details_model.dart';

class DriverAuthRepository {
  final Env env;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  late final DriverAuthProvider authApiProvider;

  DriverAuthRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
  }) {
    authApiProvider = DriverAuthProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
    );
  }
  final ValueNotifier<bool> _isLoggedIn = ValueNotifier(false);
  final ValueNotifier<UserModel?> _user = ValueNotifier(null);
  ValueNotifier<UserModel?> get user => _user;
  final ValueNotifier<String> _userRole = ValueNotifier('');
  ValueNotifier<String> get userRole => _userRole;

  /// 🚗 Register driver vehicle details
  Future<DataResponse<bool>> driverRegistrations({
    required String vehicle_number,
    required String vehicle_type,
    required String year,
    required String car_company,
    required String car_model,
  }) async {
    final userId = await SecureStorage().getUserId();
    try {
      final body = {
        "vehicle_number": vehicle_number,
        "vehicle_type": vehicle_type,
        "year": year,
        "car_company": car_company,
        "car_model": car_model,
        "user_id": userId,
      };

      await authApiProvider.driverRegister(body: body);
      return DataResponse.success(true);
    } catch (e) {
      debugPrint("Driver Registration Error: $e");
      return DataResponse.error(e.toString());
    }
  }

  /// 📤 Upload driver documents
  Future<DataResponse<bool>> profileUpdate({
    required String licensePlateNumber,
    required List<File> vehicleRegistrationDocs,
    required List<File> driverLicenses,
    required List<File> vehicleInsurances,
  }) async {
    final userId = await SecureStorage().getUserId();

    try {
      final formData = FormData.fromMap({
        "user_id": userId,
        "license_plate_number": licensePlateNumber,
        "vehicle_registration_doc": await Future.wait(
          vehicleRegistrationDocs.map(
            (file) => MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        ),
        "driver_license": await Future.wait(
          driverLicenses.map(
            (file) => MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        ),
        "vehicle_insurance": await Future.wait(
          vehicleInsurances.map(
            (file) => MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        ),
      });

      await authApiProvider.driverDocumentUploads(body: formData);
      return DataResponse.success(true);
    } catch (e) {
      debugPrint("Profile Upload Error: $e");
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> becomeDriver() async {
    final userId = await SecureStorage().getUserId();

    try {
      final formData = FormData.fromMap({"user_id": userId});
      await authApiProvider.becomeDriver(body: formData);

      // ✅ Get existing user to preserve data
      final existingUser = await SecureStorage().getUser();
      if (existingUser == null) {
        debugPrint("❌ No existing user found in storage.");
        return DataResponse.error("User not found in storage");
      }

      // ✅ Update user model with new role
      _user.value = UserModel.fromMap({
        "message": "Role updated manually to driver",
        "user": {
          "phone_number": existingUser.user.phoneNumber,
          "user_id": existingUser.user.userId,
          "role": "driver",
        },
      });

      _userRole.value = "driver";
      _isLoggedIn.value = true;

      await SecureStorage().setUser(user: _user.value!);
      await setAccessToken("_accessToken");
      final storedUser = await SecureStorage().getUser();
      debugPrint('🎉 Stored role: ${storedUser?.user.role}');

      return DataResponse.success(true);
    } catch (e) {
      debugPrint('BecomeDriver Error: $e');
      return DataResponse.error(e.toString());
    }
  }

  Future<void> setAccessToken(String token) async {
    try {
      await SecureStorage().setAccessToken(token);
      _isLoggedIn.value = true;
    } catch (e) {
      debugPrint('Set AccessToken Error: $e');
    }
  }

  /// 🚗 Fetch driver online Status
  Future<DataResponse<bool>> toggleStatus() async {
    final userId = await SecureStorage().getUserId();
    try {
      final formData = FormData.fromMap({"user_id": userId});
      await authApiProvider.driverOnlineStatus(body: formData);
      return DataResponse.success(true);
    } catch (e) {
      debugPrint('ToggleStatus Error: $e');
      return DataResponse.error(e.toString());
    }
  }

  ///  Fetch driver total Earning
  Future<DataResponse<TotalEarningResponseModel>> driverTotalEarning() async {
    try {
      final response = await authApiProvider.driverTotalEarning();
      debugPrint("📦 Raw API response: ${response}");
      final model = TotalEarningResponseModel.fromJson(
        response['data']['data'],
      );
      return DataResponse.success(model);
    } catch (e, stacktrace) {
      debugPrint("🚫 Driver Total Earning  Error: $e");
      debugPrint("Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch total earning.");
    }
  }

  /// 🚗 Fetch driver cash limits
  Future<DataResponse<CashLimitModel>> driverCashLimits() async {
    try {
      final response = await authApiProvider.driverCashLimits();
      debugPrint("📦 Raw API response: ${response['data']['data']}");
      final model = CashLimitModel.fromJson(response['data']['data']);
      return DataResponse.success(model);
    } catch (e, stacktrace) {
      debugPrint("🚫 Driver Cash Limits Error: $e");
      debugPrint("Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch cash limit.");
    }
  }

  /// 🚗 Fetch driver cash limits
  Future<DataResponse<TodaysEarningModel>> driverTodaysEarning() async {
    try {
      final response = await authApiProvider.driverTodaysEarning();
      debugPrint(response['data']['data'].toString());
      final model = TodaysEarningModel.fromJson(response['data']['data']);
      return DataResponse.success(model);
    } catch (e, stacktrace) {
      debugPrint("🚫 Driver Todays earning Error: $e");
      debugPrint("Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch todays earning.");
    }
  }

  /// 🚗 Fetch driver rides live
  Future<DataResponse<List<DriverRideModel>>> driverRides() async {
    try {
      final formData = FormData.fromMap({"city_name": "Bangalore"});
      final response = await authApiProvider.driverRides(body: formData);
      debugPrint("Raw API response: $response");
      // 👇 Fix: extract inner `data` block
      final parsed = DriverRidesResponseModel.fromJson(response['data']);

      return DataResponse.success(parsed.data);
    } catch (e, stackTrace) {
      debugPrint("🚫 Driver live rides Error: $e");
      debugPrint("Stacktrace: $stackTrace");
      return DataResponse.error("Something went wrong while fetching rides.");
    }
  }

  /// 🚗 Fetch driver scheduled rides live
  Future<DataResponse<List<DriverRideModel>>> driverScheduledRides() async {
    try {
      final formData = FormData.fromMap({"city_name": "Bangalore"});
      final response = await authApiProvider.driverScheduledRides(
        body: formData,
      );
      debugPrint("Raw API response: $response");
      // 👇 Fix: extract inner `data` block
      final parsed = DriverRidesResponseModel.fromJson(response['data']);

      return DataResponse.success(parsed.data);
    } catch (e, stackTrace) {
      debugPrint("🚫 Driver live rides Error: $e");
      debugPrint("Stacktrace: $stackTrace");
      return DataResponse.error("Something went wrong while fetching rides.");
    }
  }

  /// 🚗 Fetch driver ride details
  Future<DataResponse<RideDetailsModel>> rideDetails(int id) async {
    try {
      final Map<String, dynamic> response = await authApiProvider.rideDetails(
        id,
      );
      debugPrint("📦 Raw API response: ${response}");

      final parsed = RideDetailsResponseModel.fromJson(response['data']);
      debugPrint("✅ Parsed model: $parsed");

      if (parsed.data != null) {
        return DataResponse.success(parsed.data!);
      } else {
        return DataResponse.error(parsed.message);
      }
    } catch (e, stacktrace) {
      debugPrint("🚫 Ride Details Error: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error(
        "Something went wrong. Please try again later.",
      );
    }
  }

  /// 🚗 Fetch driver acceptRide Status
  Future<DataResponse<bool>> acceptRide(int id) async {
    try {
      await authApiProvider.driverAcceptRide(id);
      return DataResponse.success(true);
    } catch (e) {
      debugPrint('ToggleStatus Error: $e');
      return DataResponse.error(e.toString());
    }
  }

  /// 🚗 Fetch driver declineRide Status
  Future<DataResponse<bool>> declineRide(int id) async {
    try {
      final formData = FormData.fromMap({"ride_id": id});
      await authApiProvider.driverDeclineRide(body: formData);
      return DataResponse.success(true);
    } catch (e) {
      debugPrint('ToggleStatus Error: $e');
      return DataResponse.error(e.toString());
    }
  }

  /// 🚗 Fetch driver declineRide Status
  Future<DataResponse<bool>> cancelRide(int id) async {
    try {
      await authApiProvider.driverCancelRide(id);
      return DataResponse.success(true);
    } catch (e) {
      debugPrint('ToggleStatus Error: $e');
      return DataResponse.error(e.toString());
    }
  }

  /// 🚗 Fetch driver declineRide Status
  Future<DataResponse<bool>> beginRide(int id) async {
    try {
      await authApiProvider.driverBeginRide(id);
      return DataResponse.success(true);
    } catch (e) {
      debugPrint('ToggleStatus Error: $e');
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> completeRide(int id) async {
    try {
      await authApiProvider.driverCompleteRide(id);
      return DataResponse.success(true);
    } catch (e) {
      debugPrint('ToggleStatus Error: $e');
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> driverGenrateOtp(int id) async {
    try {
      await authApiProvider.driverGenrateOtp(id);
      return DataResponse.success(true);
    } catch (e) {
      debugPrint('ToggleStatus Error: $e');
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> driverVerifyOtp(int id) async {
    try {
      await authApiProvider.driverVerifyOtp(id);
      return DataResponse.success(true);
    } catch (e) {
      debugPrint('ToggleStatus Error: $e');
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<DriverSettingsModel>> getDriverProfile() async {
    try {
      final response = await authApiProvider.driverProfile(); // or dio.get(...)
      debugPrint("📦 Profile API Response: $response");
      final parsed = DriverSettingsModel.fromJson(response['data']);
      debugPrint("✅ Parsed model: $parsed");

      if (parsed.data != null) {
        return DataResponse.success(parsed);
      } else {
        return DataResponse.error(parsed.message);
      }
    } catch (e) {
      debugPrint("🚫 Profile fetch error: $e");
      return DataResponse.error("Failed to fetch profile");
    }
  }

  Future<DataResponse<DriverVehiclesDocModel>> getDriverVehiclesDoc() async {
    try {
      final response =
          await authApiProvider.driverVehiclesDoc(); // or dio.get(...)
      debugPrint("📦 Driver Vehicles Doc API Response: $response");
      final parsed = DriverVehiclesDocModel.fromJson(response['data']);
      debugPrint("✅ Parsed model: $parsed");

      if (parsed.data != null) {
        return DataResponse.success(parsed);
      } else {
        return DataResponse.error(parsed.message);
      }
    } catch (e) {
      debugPrint("🚫 Driver Doc fetch error: $e");
      return DataResponse.error("Failed to fetch Driver Vehicles Documents");
    }
  }
}
