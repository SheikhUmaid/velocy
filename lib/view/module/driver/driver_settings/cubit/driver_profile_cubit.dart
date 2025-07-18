import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';

import 'package:velocy_user_app/view/driver_auth_page/resources/driver_auth_repository.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/model/driver_settings_model.dart';

class DriverProfileCubit extends Cubit<CommonState> {
  final DriverAuthRepository driverAuthRepository;

  DriverProfileCubit({required this.driverAuthRepository})
    : super(CommonInitial());

  Future<void> fetchDriverProfile() async {
    emit(CommonLoading());
    try {
      final response = await driverAuthRepository.getDriverProfile();
      debugPrint("🧪 Cubit received response: ${response.data}");

      if (response.status == Status.success && response.data != null) {
        debugPrint("🧪Data is Comiggg : ${response}");
        emit(CommonStateSuccess<DriverSettingsModel>(data: response.data!));
      } else {
        emit(
          CommonError(
            message: response.message ?? "No driver settings details found.",
          ),
        );
      }
    } catch (e) {
      emit(CommonError(message: "Something went wrong: ${e.toString()}"));
    }
  }
}
