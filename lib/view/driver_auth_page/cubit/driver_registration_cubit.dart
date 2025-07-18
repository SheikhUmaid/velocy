import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/driver_auth_page/resources/driver_auth_repository.dart';

class DriverRegistrationCubit extends Cubit<CommonState> {
  final DriverAuthRepository driverAuthRepository;
  DriverRegistrationCubit({required this.driverAuthRepository})
    : super(CommonInitial());

  driverRegister({
    required String vehicle_number,
    required String vehicle_type,
    required String year,
    required String car_company,
    required String car_model,
  }) async {
    emit(CommonLoading());
    final res = await driverAuthRepository.driverRegistrations(
      vehicle_number: vehicle_number,
      vehicle_type: vehicle_type,
      year: year,
      car_company: car_company,
      car_model: car_model,
    );
    if (res.status == Status.success) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
