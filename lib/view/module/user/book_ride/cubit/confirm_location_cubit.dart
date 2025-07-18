import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/confirm_location_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/resources/ride_request_repository.dart';

class ConfirmLocationCubit extends Cubit<CommonState> {
  final RideRequestRepository confirmLocationRepository;
  ConfirmLocationCubit({required this.confirmLocationRepository})
    : super(CommonInitial());

  Future<void> confirmLocation({
    required ConfirmLocationRequestModel confirmLocationRequestModel,
  }) async {
    emit(CommonLoading());
    try {
      final res = await confirmLocationRepository.confirmLocation(
        confirmLocationRequestModel: confirmLocationRequestModel,
      );

      if (res.status == Status.success) {
        if (res.data == null) {
          emit(CommonError(message: "No data received"));
        }
        emit(CommonStateSuccess(data: res.data!));
      } else {
        emit(CommonError(message: res.message ?? ""));
      }
    } catch (e) {
      emit(CommonError(message: "Failed to confirm location: $e"));
    }
  }
}
