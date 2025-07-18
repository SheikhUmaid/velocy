import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/driver_auth_page/resources/driver_auth_repository.dart';

import '../../../../../service/api/response.dart';

class DriverCancelRideCubit extends Cubit<CommonState> {
  final DriverAuthRepository driverAuthRepository;

  DriverCancelRideCubit({required this.driverAuthRepository}) : super(CommonInitial());

  Future<void> driverCancelRide(int id) async {
    emit(CommonLoading());

    try {
      final response = await driverAuthRepository.cancelRide(id);

      if (response.status == Status.success) {
        emit(CommonStateSuccess(data: response.data));
      } else {
        emit(CommonError(message: response.message ?? "Failed to fetch cash limit."));
      }
    } catch (e) {
      emit(CommonError(message: "Something went wrong: ${e.toString()}"));
    }
  }
}