import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/driver_auth_page/resources/driver_auth_repository.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_online_status_cubit.dart';

class DriverHomeCashLimitCubit extends Cubit<CommonState> {
  final DriverAuthRepository driverAuthRepository;
  final OnlineStatusSwitchCubit onlineStatusSwitchCubit =
      OnlineStatusSwitchCubit();

  DriverHomeCashLimitCubit({required this.driverAuthRepository})
    : super(CommonInitial());

  Future<void> fetchCashLimit() async {
    emit(CommonLoading());

    try {
      final response = await driverAuthRepository.driverCashLimits();

      if (response.status == Status.success) {
        debugPrint(
          "DriverHomeCashLimitCubit: fetchCashLimit response: ${response.data!.isOnline}",
        );
        if (response.data != null &&
            response.data!.isOnline != null &&
            response.data!.isOnline == true) {
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
