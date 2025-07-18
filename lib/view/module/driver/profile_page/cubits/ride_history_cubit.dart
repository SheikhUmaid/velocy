import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/models/get_driver_ride_history_model.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/resouces/ride_history_repository.dart';

class RideHistoryCubit extends Cubit<CommonState> {
  final RideHistoryRepository rideHistoryRepository;
  RideHistoryCubit({required this.rideHistoryRepository})
    : super(CommonInitial());

  Future<void> getRideHistory() async {
    emit(CommonLoading());
    try {
      final res = await rideHistoryRepository.getRideHistory();
      debugPrint("RideHistoryCubit: getRideHistory response: ${res.data}");
      if (res.status == Status.success) {
        debugPrint("RideHistoryCubit: getRideHistory success: ${res.data}");
        if (res.data == null) {
          emit(CommonError(message: "No ride history found."));
        }
        emit(CommonStateSuccess(data: res.data!));
      } else {
        emit(CommonError(message: res.message ?? ""));
      }
    } catch (e) {
      debugPrint("RideHistoryCubit: getRideHistory error: $e");
      emit(CommonError(message: "Something went wrong: ${e.toString()}"));
    }
  }

  Future<void> fetchDriverRideHistory() async {
    emit(CommonLoading());
    try {
      final response = await await rideHistoryRepository.getDriverRideHistory();
      debugPrint("🧪 Cubit received response: ${response.data}");

      if (response.status == Status.success && response.data != null) {
        debugPrint("🧪Data is Comiggg : ${response}");
        emit(CommonStateSuccess<DriverRideHistoryModel>(data: response.data!));
      } else {
        emit(
          CommonError(
            message: response.message ?? "No driver settings details found.",
          ),
        );
      }
    } catch (e) {
      emit(CommonError(message: "Something went wrong: ${e.toString()}"));
    }
  }
}
