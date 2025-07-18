import 'package:flutter/cupertino.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/models/get_live_offer_response_model.dart';
import 'package:velocy_user_app/view/pool/models/request/add_stops_request_model.dart';
import 'package:velocy_user_app/view/pool/models/request/create_ride_request_model.dart';
import 'package:velocy_user_app/view/pool/models/request/estimated_price_request_model.dart';
import 'package:velocy_user_app/view/pool/models/response/add_stops_response_model.dart';
import 'package:velocy_user_app/view/pool/models/response/create_ride_response_model.dart';
import 'package:velocy_user_app/view/pool/resources/car_pooling_api_provider.dart';

class CarPoolingRepository {
  final Env env;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  late final CarPoolingApiProvider carPoolingApiProvider;

  CarPoolingRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
  }) {
    carPoolingApiProvider = CarPoolingApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
    );
  }

  Future<DataResponse<GetLiveOfferResponseModel>> estimatedPrice({
    required EstimatedPriceRequestModel estimatedPriceRequestModel,
  }) async {
    try {
      final response = await carPoolingApiProvider.estimatedPrice(
        estimatedPriceRequestModel: estimatedPriceRequestModel,
      );
      debugPrint("📦 Raw API response: $response");

      final parsed = GetLiveOfferResponseModel.fromJson(response['data']);
      if (parsed.status == true) {
        return DataResponse.success(parsed);
      } else {
        return DataResponse.error(
          parsed.message ?? "Failed to fetch estimated price",
        );
      }
    } catch (e, stacktrace) {
      debugPrint("🚨 Error fetching estimated price: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch estimated price.");
    }
  }

  Future<DataResponse<CreateRideResponseModel>> createRide({
    required CreateRideRequestModel createRideRequestModel,
  }) async {
    try {
      final response = await carPoolingApiProvider.createRide(
        createRideRequestModel: createRideRequestModel,
      );
      debugPrint("📦 Raw API response: $response");

      final parsed = CreateRideResponseModel.fromMap(response['data']);
      if (parsed.status == true) {
        return DataResponse.success(parsed);
      } else {
        return DataResponse.error(parsed.message ?? "Failed to create ride");
      }
    } catch (e, stacktrace) {
      debugPrint("🚨 Error creating ride: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to create ride.");
    }
  }

  Future<DataResponse<AddStopsResponseModel>> addStops({
    required AddStopsRequestModel addStopsRequestModel,
  }) async {
    try {
      final response = await carPoolingApiProvider.addStops(
        addStopsRequestModel: addStopsRequestModel,
      );
      debugPrint("📦 Raw API response: $response");

      final parsed = AddStopsResponseModel.fromMap(response['data']);
      if (parsed.status == true) {
        return DataResponse.success(parsed);
      } else {
        return DataResponse.error(parsed.message ?? "Failed to add stops");
      }
    } catch (e, stacktrace) {
      debugPrint("🚨 Error adding stops: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to add stops.");
    }
  }
}
