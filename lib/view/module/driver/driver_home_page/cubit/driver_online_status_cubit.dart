import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/driver_auth_page/resources/driver_auth_repository.dart';

import '../../../../../service/api/response.dart';

class OnlineStatusSwitchCubit extends Cubit<bool> {
  OnlineStatusSwitchCubit() : super(false); // Initial state is false

  void toggle() => emit(!state);

  void setTrue() => emit(true);

  void setFalse() => emit(false);
}

class DriverOnlineStatusCubit extends Cubit<CommonState> {
  final DriverAuthRepository driverAuthRepository;
  final OnlineStatusSwitchCubit onlineStatusSwitchCubit =
      OnlineStatusSwitchCubit();

  DriverOnlineStatusCubit({required this.driverAuthRepository})
    : super(CommonInitial());

  Future<void> driverOnlineStatusUpdate() async {
    emit(CommonLoading());

    try {
      final response = await driverAuthRepository.toggleStatus();

      if (response.status == Status.success) {
        if (response.data != null && response.data == true) {
          onlineStatusSwitchCubit.setTrue();
        } else {
          onlineStatusSwitchCubit.setFalse();
        }
        emit(CommonStateSuccess(data: response.data));
      } else {
        emit(
          CommonError(
            message: response.message ?? "Failed to fetch cash limit.",
          ),
        );
      }
    } catch (e) {
      emit(CommonError(message: "Something went wrong: ${e.toString()}"));
    }
  }
}
