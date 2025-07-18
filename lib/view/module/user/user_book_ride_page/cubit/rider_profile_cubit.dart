import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/resources/rider_profile_repository.dart';

class RiderProfileCubit extends Cubit<CommonState> {
  final RiderProfileRepository riderProfileRepository;
  RiderProfileCubit({required this.riderProfileRepository})
    : super(CommonInitial());

  Future<void> getRiderProfile() async {
    debugPrint("RiderProfileCubit: getRiderProfile called");
    emit(CommonLoading());
    try {
      final res = await riderProfileRepository.getRiderProfile();
      debugPrint("RiderProfileCubit: getRiderProfile response: $res");
      if (res.status == Status.success) {
        debugPrint("RiderProfileCubit: getRiderProfile success: ${res.data}");
        if (res.data == null) {
          emit(CommonError(message: "No rider profile found."));
        }
        emit(CommonStateSuccess(data: res.data!));
      } else {
        emit(CommonError(message: res.message ?? ""));
      }
    } catch (e) {
      debugPrint("RiderProfileCubit: getRiderProfile error: $e");
      emit(
        CommonError(message: "An error occurred while fetching rider profile."),
      );
    }
  }
}
