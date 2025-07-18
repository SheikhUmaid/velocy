import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/module/rental/resources/rental_repository.dart';

class DeleteRentedVehicleCubit extends Cubit<CommonState> {
  final RentalRepository rentalRepository;
  DeleteRentedVehicleCubit({required this.rentalRepository})
    : super(CommonInitial());

  Future<void> deleteRentedVehicle({required String vehicleId}) async {
    debugPrint(
      "DeleteRentedVehicleCubit: deleteRentedVehicle called with vehicleId: $vehicleId",
    );
    emit(CommonLoading());
    try {
      final res = await rentalRepository.deleteRentedVehicle(
        vehicleId: vehicleId,
      );
      debugPrint(
        "DeleteRentedVehicleCubit: deleteRentedVehicle response: $res",
      );
      if (res.status == Status.success) {
        debugPrint(
          "DeleteRentedVehicleCubit: deleteRentedVehicle success: ${res.data}",
        );
        if (res.data == null) {
          emit(CommonError(message: "No vehicle data found."));
        }
        emit(CommonStateSuccess(data: res.data!));
      } else {
        emit(CommonError(message: res.message ?? ""));
      }
    } catch (e) {
      debugPrint("DeleteRentedVehicleCubit: deleteRentedVehicle error: $e");
      emit(
        CommonError(
          message: "An error occurred while deleting the rented vehicle.",
        ),
      );
    }
  }
}
