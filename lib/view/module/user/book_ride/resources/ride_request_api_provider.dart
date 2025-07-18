import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/add_ride_stops_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/confirm_location_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/estimate_price_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/ride_booking_request_model.dart';

class RideRequestApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;

  RideRequestApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> confirmLocation({
    required ConfirmLocationRequestModel confirmLocationRequestModel,
  }) async {
    final uri = "$baseUrl/rider/confirm_location/";

    return await apiProvider.post(
      uri,
      confirmLocationRequestModel.toMap(),
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> addRideStops({
    required AddRideStopsRequestModel rideStopsRequestModel,
  }) async {
    final uri = "$baseUrl/rider/ride-stops/";

    return await apiProvider.post(
      uri,
      rideStopsRequestModel.toMap(),
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> estimatePrice({
    required EstimatePriceRequestModel estimatePriceRequestModel,
  }) async {
    final uri = "$baseUrl/rider/estimate-price/";

    return await apiProvider.post(
      uri,
      estimatePriceRequestModel.toMap(),
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> rideBooking({
    required RideBookingRequestModel rideBookingRequestModel,
  }) async {
    final uri =
        "$baseUrl/rider/ride-booking/${rideBookingRequestModel.rideId}/";

    return await apiProvider.patch(
      uri,
      rideBookingRequestModel.toMap(),
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> vehicleTypes() async {
    final uri = Uri.parse("$baseUrl/rider/vehicle-types/");

    return await apiProvider.get(uri);
  }

  Future<dynamic> liveTracking({required String rideId}) async {
    final uri = Uri.parse("$baseUrl/rider/live-tracking/$rideId");

    return await apiProvider.get(uri, token: authRepository.accessToken);
  }
}
