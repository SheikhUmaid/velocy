import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';

class LoginCubit extends Cubit<CommonState> {
  final AuthRepository authRepository;
  LoginCubit({required this.authRepository}) : super(CommonInitial());

  login({required String phoneNumber, required String password}) async {
    emit(CommonLoading());

    final res = await authRepository.login(
      phoneNumber: phoneNumber,
      password: password,
    );

    if (res.status == Status.success) {
      emit(CommonSuccessWithRole(role: res.data ?? ""));
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
