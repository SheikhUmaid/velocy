import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/models/get_schedule_rides_model.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/resouces/ride_history_repository.dart';

class ScheduledRideCubit extends Cubit<CommonState> {
  final RideHistoryRepository rideHistoryRepository;
  ScheduledRideCubit({required this.rideHistoryRepository})
    : super(CommonInitial());

  UpcomigScheduledModel? scheduledRideModel;

  Future<void> fetchScheduledRides() async {
    emit(CommonLoading());
    try {
      final response = await rideHistoryRepository.getScheduledRideHistory();
      if (response.status == Status.success && response.data != null) {
        emit(CommonStateSuccess<UpcomigScheduledModel>(data: response.data!));
      } else {
        emit(
          CommonError(message: response.message ?? "No scheduled rides found."),
        );
      }
    } catch (e) {
      emit(CommonError(message: "Error: ${e.toString()}"));
    }
  }
}
