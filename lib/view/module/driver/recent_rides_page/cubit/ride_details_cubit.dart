import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/driver_auth_page/resources/driver_auth_repository.dart';

import '../model/ride_details_model.dart';

class RideDetailsCubit extends Cubit<CommonState> {
  final DriverAuthRepository driverAuthRepository;

  RideDetailsCubit({required this.driverAuthRepository})
    : super(CommonInitial());

  Future<void> fetchRideDetails(int id) async {
    emit(CommonLoading());
    try {
      final response = await driverAuthRepository.rideDetails(id);
      debugPrint("🧪 Cubit received response: ${response.data}");

      if (response.status == Status.success && response.data != null) {
        debugPrint("🧪Data is Comig : ${response}");
        emit(CommonStateSuccess<RideDetailsModel>(data: response.data!));
      } else {
        emit(
          CommonError(message: response.message ?? "No ride details found."),
        );
      }
    } catch (e) {
      emit(CommonError(message: "Something went wrong: ${e.toString()}"));
    }
  }
}
