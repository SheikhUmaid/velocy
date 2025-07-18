import 'package:flutter/material.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/module/rental/models/request/add_vehicle_request_model.dart';
import 'package:velocy_user_app/view/module/rental/models/request/edit_vehicle_details_request_model.dart';

class RentalApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;

  RentalApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> myGarage() async {
    debugPrint("RentalApiProvider: myGarage called with baseUrl: $baseUrl");
    final uri = Uri.parse("$baseUrl/rent/my-garage/");

    return await apiProvider.get(uri, token: authRepository.accessToken);
  }

  Future<dynamic> addVehicle({
    required AddVehicleRequestModel addVehicleRequestModel,
  }) async {
    debugPrint("RentalApiProvider: addVehicle called with baseUrl: $baseUrl");
    final uri = "$baseUrl/rent/add-your-vehicle/";

    return await apiProvider.post(
      uri,
      addVehicleRequestModel.toMap(),
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> deleteRentedVehicle({required String vehicleId}) async {
    debugPrint(
      "RentalApiProvider: deleteRentedVehicle called with vehicleId: $vehicleId",
    );
    final uri = Uri.parse(
      "$baseUrl/rent/ddeveelete-rented-vehicle/$vehicleId/",
    );

    return await apiProvider.delete(uri, token: authRepository.accessToken);
  }

  Future<dynamic> vehicleDetails({required String vehicleId}) async {
    debugPrint(
      "RentalApiProvider: vehicleDetails called with vehicleId: $vehicleId",
    );
    final uri = Uri.parse("$baseUrl/rent/vehicles-details-edit/$vehicleId/");

    return await apiProvider.get(uri, token: authRepository.accessToken);
  }

  Future<dynamic> editVehicleDetails({
    required EditVehicleDetailsRequestModel editVehicleDetailsRequestModel,
  }) async {
    debugPrint(
      "RentalApiProvider: editVehicleDetails called with baseUrl: $baseUrl",
    );
    final uri =
        "$baseUrl/rent/vehicles-details-edit/${editVehicleDetailsRequestModel.vehicleId}/";

    return await apiProvider.put(
      uri,
      editVehicleDetailsRequestModel.toMap(),
      token: authRepository.accessToken,
    );
  }
}
