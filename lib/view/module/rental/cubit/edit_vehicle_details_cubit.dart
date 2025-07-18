import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/module/rental/models/request/edit_vehicle_details_request_model.dart';
import 'package:velocy_user_app/view/module/rental/resources/rental_repository.dart';

class EditVehicleCubit extends Cubit<CommonState> {
  final RentalRepository rentalRepository;
  EditVehicleCubit({required this.rentalRepository}) : super(CommonInitial());

  Future<void> editVehicle({
    required EditVehicleDetailsRequestModel editVehicleDetailsRequestModel,
  }) async {
    debugPrint("EditVehicleCubit: editVehicle called");
    emit(CommonLoading());
    try {
      final res = await rentalRepository.editVehicleDetails(
        editVehicleDetailsRequestModel: editVehicleDetailsRequestModel,
      );
      debugPrint("EditVehicleCubit: editVehicle response: $res");
      if (res.status == Status.success) {
        debugPrint("EditVehicleCubit: editVehicle success: ${res.data}");
        if (res.data == null) {
          emit(CommonError(message: "No vehicle data found."));
        }
        emit(CommonStateSuccess(data: res.data!));
      } else {
        emit(CommonError(message: res.message ?? ""));
      }
    } catch (e) {
      debugPrint("EditVehicleCubit: editVehicle error: $e");
      emit(
        CommonError(
          message: "An error occurred while editing vehicle details.",
        ),
      );
    }
  }
}
