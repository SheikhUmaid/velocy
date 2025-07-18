import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/estimate_price_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/resources/ride_request_repository.dart';

class EstimatePriceCubit extends Cubit<CommonState> {
  final RideRequestRepository confirmLocationRepository;
  EstimatePriceCubit({required this.confirmLocationRepository})
    : super(CommonInitial());

  Future<void> estimatePrice({
    required EstimatePriceRequestModel estimatePriceRequestModel,
  }) async {
    emit(CommonLoading());
    try {
      final res = await confirmLocationRepository.estimatePrice(
        estimatePriceRequestModel: estimatePriceRequestModel,
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
      emit(CommonError(message: "Failed to estimate price: $e"));
    }
  }
}
