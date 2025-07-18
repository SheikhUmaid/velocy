import 'package:flutter/cupertino.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:velocy_user_app/service/api/response.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/models/get_live_offer_response_model.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/resources/live_offer_api_provider.dart';

class LiveOfferRepository {
  final Env env;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  late final LiveOfferApiProvider liveOfferApiProvider;

  LiveOfferRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
  }) {
    liveOfferApiProvider = LiveOfferApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
    );
  }

  Future<DataResponse<GetLiveOfferResponseModel>> getLiveOffers() async {
    try {
      final response = await liveOfferApiProvider.getLiveOffers();
      debugPrint("📦 Raw API response: $response");

      final parsed = GetLiveOfferResponseModel.fromJson(response['data']);
      if (parsed.status == true) {
        return DataResponse.success(parsed);
      } else {
        return DataResponse.error(parsed.message ?? "No offers available");
      }
    } catch (e, stacktrace) {
      debugPrint("🚫 Get Live Offers Error: $e");
      debugPrint("📛 Stacktrace: $stacktrace");
      return DataResponse.error("Failed to fetch live offers.");
    }
  }
}
