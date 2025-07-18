import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/ride_booking_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/resources/ride_request_repository.dart';

class RideBookingCubit extends Cubit<CommonState> {
  final RideRequestRepository confirmLocationRepository;
  RideBookingCubit({required this.confirmLocationRepository})
    : super(CommonInitial());

  Future<void> rideBooking({
    required RideBookingRequestModel rideBookingRequestModel,
  }) async {
    emit(CommonLoading());
    try {
      final res = await confirmLocationRepository.rideBooking(
        rideBookingRequestModel: rideBookingRequestModel,
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
      emit(CommonError(message: "Failed to book ride: $e"));
    }
  }
}
