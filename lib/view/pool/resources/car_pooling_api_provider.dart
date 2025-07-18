import 'package:flutter/material.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/pool/models/request/add_stops_request_model.dart';
import 'package:velocy_user_app/view/pool/models/request/create_ride_request_model.dart';
import 'package:velocy_user_app/view/pool/models/request/estimated_price_request_model.dart';

class CarPoolingApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;

  CarPoolingApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> estimatedPrice({
    required EstimatedPriceRequestModel estimatedPriceRequestModel,
  }) async {
    debugPrint(
      "CarPoolingApiProvider: estimatedPrice called with baseUrl: $baseUrl",
    );
    final uri = "$baseUrl/pooling/estimated-price/";

    return await apiProvider.post(
      uri,
      estimatedPriceRequestModel.toMap(),
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> createRide({
    required CreateRideRequestModel createRideRequestModel,
  }) async {
    debugPrint(
      "CarPoolingApiProvider: createRide called with baseUrl: $baseUrl",
    );
    final uri = "$baseUrl/pooling/create-ride/";

    return await apiProvider.post(
      uri,
      createRideRequestModel.toMap(),
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> addStops({
    required AddStopsRequestModel addStopsRequestModel,
  }) async {
    debugPrint("CarPoolingApiProvider: addStops called with baseUrl: $baseUrl");
    final uri = "$baseUrl/pooling/add-stops/${addStopsRequestModel.rideId}/";

    return await apiProvider.post(
      uri,
      addStopsRequestModel.toMap(),
      token: authRepository.accessToken,
    );
  }
}
