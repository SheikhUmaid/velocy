import 'package:flutter/cupertino.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/models/get_rider_profile_response_model.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/resources/rider_profile_api_provider.dart';

class RiderProfileRepository {
  final Env env;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  late final RiderProfileApiProvider riderProfileApiProvider;

  RiderProfileRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
  }) {
    riderProfileApiProvider = RiderProfileApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
    );
  }

  Future<DataResponse<GetRiderProfileResponseModel>> getRiderProfile() async {
    try {
      final response = await riderProfileApiProvider.getRiderProfile();
      debugPrint("📦 Raw API response: $response");

      final parsed = GetRiderProfileResponseModel.fromMap(response['data']);

      return DataResponse.success(parsed);
    } catch (e, stacktrace) {
      debugPrint("🚨 Error fetching rider profile: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch rider profile.");
    }
  }
}
