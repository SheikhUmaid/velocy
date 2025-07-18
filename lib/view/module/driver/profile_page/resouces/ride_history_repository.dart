import 'package:flutter/cupertino.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/models/get_driver_ride_history_model.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/models/get_ride_history_response_model.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/models/get_schedule_rides_model.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/resouces/ride_history_api_provider.dart';

class RideHistoryRepository {
  final Env env;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  late final RideHistoryApiProvider rideHistoryApiProvider;

  RideHistoryRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
  }) {
    rideHistoryApiProvider = RideHistoryApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
    );
  }

  Future<DataResponse<DriverRideHistoryModel>> getDriverRideHistory() async {
    try {
      final response = await rideHistoryApiProvider.getDriverRideHistory();
      debugPrint("📦 Raw API response: $response");

      final parsed = DriverRideHistoryModel.fromJson(response['data']);
      if (parsed.status == true) {
        return DataResponse.success(parsed);
      } else {
        return DataResponse.error(parsed.message ?? "No History available");
      }
    } catch (e, stacktrace) {
      debugPrint("🚫 Get Driver Ride History Error: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch driver ride history.");
    }
  }

  Future<DataResponse<UpcomigScheduledModel>> getScheduledRideHistory() async {
    try {
      final response = await rideHistoryApiProvider.getDriverScheduledRides();
      debugPrint("📦 Raw API response: $response");

      final parsed = UpcomigScheduledModel.fromJson(response['data']);
      if (parsed.status == true) {
        return DataResponse.success(parsed);
      } else {
        return DataResponse.error(
          parsed.message ?? "No scheduled rides available",
        );
      }
    } catch (e, stacktrace) {
      debugPrint("🚫 Get Scheduled Rides Error: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch scheduled rides.");
    }
  }

  Future<DataResponse<GetRideHistoryResponseModel>> getRideHistory() async {
    try {
      final response = await rideHistoryApiProvider.getRideHistory();
      debugPrint("📦 Raw API response: $response");

      final parsed = GetRideHistoryResponseModel.fromMap(response['data']);
      if (parsed.status == true) {
        return DataResponse.success(parsed);
      } else {
        return DataResponse.error(
          parsed.message ?? "No ride history available",
        );
      }
    } catch (e, stacktrace) {
      debugPrint("🚫 Get Ride History Error: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch ride history.");
    }
  }
}
