import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';

class RegisterCubit extends Cubit<CommonState> {
  final AuthRepository authRepository;
  RegisterCubit({required this.authRepository}) : super(CommonInitial());

  register({
    required String phoneNumber,
    required String password,
    required String otp,
    required String confirmpassword,
  }) async {
    emit(CommonLoading());
    final res = await authRepository.register(
      phoneNumber: phoneNumber,
      password: password,
      otp: otp,
      confirmpassword: confirmpassword,
    );
    if (res.status == Status.success) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
