import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/module/rental/models/request/add_vehicle_request_model.dart';
import 'package:velocy_user_app/view/module/rental/resources/rental_repository.dart';

class AddVehicleCubit extends Cubit<CommonState> {
  final RentalRepository rentalRepository;
  AddVehicleCubit({required this.rentalRepository}) : super(CommonInitial());

  Future<void> addVehicle({
    required AddVehicleRequestModel addVehicleRequestModel,
  }) async {
    debugPrint("AddVehicleCubit: addVehicle called");
    emit(CommonLoading());
    try {
      final res = await rentalRepository.addVehicle(
        addVehicleRequestModel: addVehicleRequestModel,
      );
      debugPrint("AddVehicleCubit: addVehicle response: $res");
      if (res.status == Status.success) {
        debugPrint("AddVehicleCubit: addVehicle success: ${res.data}");
        if (res.data == null) {
          emit(CommonError(message: "No vehicle data found."));
        }
        emit(CommonStateSuccess(data: res.data!));
      } else {
        emit(CommonError(message: res.message ?? ""));
      }
    } catch (e) {
      debugPrint("AddVehicleCubit: addVehicle error: $e");
      emit(
        CommonError(message: "An error occurred while adding vehicle data."),
      );
    }
  }
}
