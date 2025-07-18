import 'package:flutter/cupertino.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/module/rental/models/request/add_vehicle_request_model.dart';
import 'package:velocy_user_app/view/module/rental/models/request/edit_vehicle_details_request_model.dart';
import 'package:velocy_user_app/view/module/rental/models/response/edit_vehicle_details_response_model.dart';
import 'package:velocy_user_app/view/module/rental/models/response/my_garage_response_model.dart';
import 'package:velocy_user_app/view/module/rental/models/response/vehicle_details_response_model.dart';
import 'package:velocy_user_app/view/module/rental/resources/rental_api_provider.dart';

class RentalRepository {
  final Env env;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  late final RentalApiProvider rentalApiProvider;

  RentalRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
  }) {
    rentalApiProvider = RentalApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
    );
  }

  Future<DataResponse<MyGarageResponseModel>> myGarage() async {
    try {
      final response = await rentalApiProvider.myGarage();
      debugPrint("📦 Raw API response: $response");

      final parsed = MyGarageResponseModel.fromMap(response['data']);
      return DataResponse.success(parsed);
    } catch (e, stacktrace) {
      debugPrint("❌ Error fetching my garage: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch my garage data.");
    }
  }

  Future<DataResponse<Map<String, dynamic>>> addVehicle({
    required AddVehicleRequestModel addVehicleRequestModel,
  }) async {
    try {
      final response = await rentalApiProvider.addVehicle(
        addVehicleRequestModel: addVehicleRequestModel,
      );
      debugPrint("📦 Raw API response: $response");
      return DataResponse.success(response['data'] as Map<String, dynamic>);
    } catch (e, stacktrace) {
      debugPrint("❌ Error adding vehicle: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to add vehicle.");
    }
  }

  Future<DataResponse<Map<String, dynamic>>> deleteRentedVehicle({
    required String vehicleId,
  }) async {
    try {
      final response = await rentalApiProvider.deleteRentedVehicle(
        vehicleId: vehicleId,
      );
      debugPrint("📦 Raw API response: $response");
      return DataResponse.success(response['data'] as Map<String, dynamic>);
    } catch (e, stacktrace) {
      debugPrint("❌ Error deleting rented vehicle: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to delete rented vehicle.");
    }
  }

  Future<DataResponse<VehicleDetailsResponseModel>> vehicleDetails({
    required String vehicleId,
  }) async {
    try {
      final response = await rentalApiProvider.vehicleDetails(
        vehicleId: vehicleId,
      );
      debugPrint("📦 Raw API response: $response");
      final parse = VehicleDetailsResponseModel.fromMap(response['data']);
      return DataResponse.success(parse);
    } catch (e, stacktrace) {
      debugPrint("❌ Error fetching vehicle details: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch vehicle details.");
    }
  }

  Future<DataResponse<EditVehicleDetails>> editVehicleDetails({
    required EditVehicleDetailsRequestModel editVehicleDetailsRequestModel,
  }) async {
    try {
      final response = await rentalApiProvider.editVehicleDetails(
        editVehicleDetailsRequestModel: editVehicleDetailsRequestModel,
      );
      debugPrint("📦 Raw API response: $response");
      final parse = EditVehicleDetails.fromMap(response['data']);
      return DataResponse.success(parse);
    } catch (e, stacktrace) {
      debugPrint("❌ Error fetching vehicle details: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch vehicle details.");
    }
  }
}
