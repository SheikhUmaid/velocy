import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/resources/live_offer_repository.dart';

class LiveOfferCubit extends Cubit<CommonState> {
  final LiveOfferRepository liveOfferRepository;
  LiveOfferCubit({required this.liveOfferRepository}) : super(CommonInitial());

  Future<void> getLiveOffers() async {
    debugPrint("LiveOfferCubit: getLiveOffers called");
    emit(CommonLoading());
    try {
      final res = await liveOfferRepository.getLiveOffers();
      debugPrint("LiveOfferCubit: getLiveOffers response: $res");
      if (res.status == Status.success) {
        debugPrint("LiveOfferCubit: getLiveOffers success: ${res.data}");
        if (res.data == null ||
            res.data!.liveOffers == null ||
            res.data!.liveOffers!.isEmpty) {
          emit(CommonError(message: "No live offers available."));
        }
        emit(CommonStateSuccess(data: res.data!));
      } else {
        emit(CommonError(message: res.message ?? ""));
      }
    } catch (e) {
      debugPrint("LiveOfferCubit: getLiveOffers error: $e");
      emit(CommonError(message: "Failed to fetch live offers."));
    }
  }
}
