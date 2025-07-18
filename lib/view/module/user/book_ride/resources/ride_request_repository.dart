import 'package:flutter/cupertino.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/add_ride_stops_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/confirm_location_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/response/confirm_location_response_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/estimate_price_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/ride_booking_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/response/estimate_price_response_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/response/vehicle_types_response_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/resources/ride_request_api_provider.dart';

class RideRequestRepository {
  final Env env;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  late final RideRequestApiProvider rideRequestApiProvider;

  RideRequestRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
  }) {
    rideRequestApiProvider = RideRequestApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
    );
  }

  Future<DataResponse<ConfirmLocationResponseModel>> confirmLocation({
    required ConfirmLocationRequestModel confirmLocationRequestModel,
  }) async {
    try {
      final response = await rideRequestApiProvider.confirmLocation(
        confirmLocationRequestModel: confirmLocationRequestModel,
      );
      debugPrint("📦 Raw API response: $response");

      final parsed = ConfirmLocationResponseModel.fromMap(response['data']);

      return DataResponse.success(parsed);
    } catch (e, stacktrace) {
      debugPrint("🚫 Confirm Location Error: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to confirm location.");
    }
  }

  Future<DataResponse<ConfirmLocationResponseModel>> addRideStop({
    required AddRideStopsRequestModel addRideStopsRequestModel,
  }) async {
    try {
      final response = await rideRequestApiProvider.addRideStops(
        rideStopsRequestModel: addRideStopsRequestModel,
      );
      debugPrint("📦 Raw API response: $response");

      // TODO: parse the response with the correct model
      final parsed = ConfirmLocationResponseModel.fromMap(response['data']);

      return DataResponse.success(parsed);
    } catch (e, stacktrace) {
      debugPrint("🚫 Add Ride Stop Error: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to add ride stop.");
    }
  }

  Future<DataResponse<EstimatePriceResponseModel>> estimatePrice({
    required EstimatePriceRequestModel estimatePriceRequestModel,
  }) async {
    try {
      final response = await rideRequestApiProvider.estimatePrice(
        estimatePriceRequestModel: estimatePriceRequestModel,
      );
      debugPrint("📦 Raw API response: $response");

      final parsed = EstimatePriceResponseModel.fromMap(response['data']);

      return DataResponse.success(parsed);
    } catch (e, stacktrace) {
      debugPrint("🚫 Estimate Price Error: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to estimate price.");
    }
  }

  Future<DataResponse<ConfirmLocationResponseModel>> rideBooking({
    required RideBookingRequestModel rideBookingRequestModel,
  }) async {
    try {
      final response = await rideRequestApiProvider.rideBooking(
        rideBookingRequestModel: rideBookingRequestModel,
      );
      debugPrint("📦 Raw API response: $response");

      // TODO: parse the response with the correct model
      final parsed = ConfirmLocationResponseModel.fromMap(response['data']);

      return DataResponse.success(parsed);
    } catch (e, stacktrace) {
      debugPrint("🚫 Ride Booking Error: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to book ride.");
    }
  }

  Future<DataResponse<VehicleTypesResponseModel>> vehicleTypes() async {
    try {
      final response = await rideRequestApiProvider.vehicleTypes();
      debugPrint("📦 Raw API response: $response");

      final parsed = VehicleTypesResponseModel.fromMap(response['data']);

      return DataResponse.success(parsed);
    } catch (e, stacktrace) {
      debugPrint("🚫 Get Vehicle Types Error: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch vehicle types.");
    }
  }

  Future<DataResponse<ConfirmLocationResponseModel>> liveTracking({
    required String rideId,
  }) async {
    try {
      final response = await rideRequestApiProvider.liveTracking(
        rideId: rideId,
      );
      debugPrint("📦 Raw API response: $response");

      // TODO: parse the response with the correct model
      final parsed = ConfirmLocationResponseModel.fromMap(response['data']);

      return DataResponse.success(parsed);
    } catch (e, stacktrace) {
      debugPrint("🚫 Live Tracking Error: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to get live tracking data.");
    }
  }
}
