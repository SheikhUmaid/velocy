import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/module/rental/resources/rental_repository.dart';

class MyGarageCubit extends Cubit<CommonState> {
  final RentalRepository rentalRepository;
  MyGarageCubit({required this.rentalRepository}) : super(CommonInitial());

  Future<void> myGarage() async {
    debugPrint("MyGarageCubit: myGarage called");
    emit(CommonLoading());
    try {
      final res = await rentalRepository.myGarage();
      debugPrint("MyGarageCubit: myGarage response: $res");
      if (res.status == Status.success) {
        debugPrint("MyGarageCubit: myGarage success: ${res.data}");
        if (res.data == null) {
          emit(CommonError(message: "No garage data found."));
        }
        emit(CommonStateSuccess(data: res.data!));
      } else {
        emit(CommonError(message: res.message ?? ""));
      }
    } catch (e) {
      debugPrint("MyGarageCubit: myGarage error: $e");
      emit(
        CommonError(message: "An error occurred while fetching garage data."),
      );
    }
  }
}
