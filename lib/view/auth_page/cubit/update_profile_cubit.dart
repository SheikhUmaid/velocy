import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';

class ProfileUpdateCubit extends Cubit<CommonState> {
  final AuthRepository authRepository;
  ProfileUpdateCubit({required this.authRepository}) : super(CommonInitial());

  updateProfile({
    required String username,
    required File profile,
    required String gender,
    required String street,
    required String area,
    required File adharcard,
    required String address_type,
  }) async {
    emit(CommonLoading());
    final res = await authRepository.profileUpdate(
      username: username,
      profile: profile,
      gender: gender,
      street: street,
      area: area,
      aadharCard: adharcard,
      addressType: address_type,
    );
    if (res.status == Status.success) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
