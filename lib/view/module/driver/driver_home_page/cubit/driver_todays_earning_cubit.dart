import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/driver_auth_page/resources/driver_auth_repository.dart';

class DriverHomeTodaysEarningCubit extends Cubit<CommonState> {
  final DriverAuthRepository driverAuthRepository;

  DriverHomeTodaysEarningCubit({required this.driverAuthRepository})
    : super(CommonInitial());

  Future<void> fetchTodaysEarning() async {
    emit(CommonLoading());

    try {
      final response = await driverAuthRepository.driverTodaysEarning();

      if (response.status == Status.success) {
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

  Future<void> fetchTotalEarning() async {
    emit(CommonLoading());

    try {
      final response = await driverAuthRepository.driverTotalEarning();

      if (response.status == Status.success) {
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
