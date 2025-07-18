import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/driver_auth_page/resources/driver_auth_repository.dart';

import '../../../service/local_storage/secure_storage.dart';

class DriverDocumentUploadCubit extends Cubit<CommonState> {
  final DriverAuthRepository driverAuthRepository;

  DriverDocumentUploadCubit({required this.driverAuthRepository})
    : super(CommonInitial());

  Future<void> uploadDocuments({
    required String licensePlateNumber,
    required List<File> vehicleRegistrationDocs,
    required List<File> driverLicenses,
    required List<File> vehicleInsurances,
  }) async {
    emit(CommonLoading());

    final res = await driverAuthRepository.profileUpdate(
      licensePlateNumber: licensePlateNumber,
      vehicleRegistrationDocs: vehicleRegistrationDocs,
      driverLicenses: driverLicenses,
      vehicleInsurances: vehicleInsurances,
    );

    if (res.status == Status.success) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? "Document upload failed."));
    }
  }

  Future<void> becomeDriver() async {
    emit(CommonLoading());

    final res = await driverAuthRepository.becomeDriver();

    if (res.status == Status.success) {

      emit(CommonStateSuccess(data: res.data));
    } else {
      emit(CommonError(message: res.message ?? "Failed to become driver."));
    }
  }

}
