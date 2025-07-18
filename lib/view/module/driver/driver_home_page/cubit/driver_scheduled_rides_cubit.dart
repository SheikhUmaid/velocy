import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/driver_auth_page/resources/driver_auth_repository.dart';

import '../model/driver_rides_model.dart';

class DriverScheduledRidesCubit extends Cubit<CommonState> {
  final DriverAuthRepository driverAuthRepository;

  DriverScheduledRidesCubit({required this.driverAuthRepository}) : super(CommonInitial());

  Future<void> fetchScheduledRides() async {
    emit(CommonLoading());
    try {
      final response = await driverAuthRepository.driverScheduledRides();
      if (response.status == Status.success && response.data != null) {
        emit(CommonDataFetchSuccess<DriverRideModel>(data: response.data!));
      } else {
        emit(CommonError(message: response.message ?? "Failed to fetch rides."));
      }
    } catch (e) {
      emit(CommonError(message: "Something went wrong: ${e.toString()}"));
    }
  }
}


