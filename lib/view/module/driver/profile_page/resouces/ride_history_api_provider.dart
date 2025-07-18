import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';

class RideHistoryApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;

  RideHistoryApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> getRideHistory() async {
    final uri = Uri.parse("$baseUrl/rider/rider-ride-history/");

    return await apiProvider.get(uri, token: authRepository.accessToken);
  }

  Future<dynamic> getDriverRideHistory() async {
    final uri = Uri.parse("$baseUrl/driver/driver-ride-history/");

    return await apiProvider.get(uri, token: authRepository.accessToken);
  }

  Future<dynamic> getDriverScheduledRides() async {
    final uri = Uri.parse("$baseUrl/driver/driver-upcoming-rides/");

    return await apiProvider.get(uri, token: authRepository.accessToken);
  }
}
