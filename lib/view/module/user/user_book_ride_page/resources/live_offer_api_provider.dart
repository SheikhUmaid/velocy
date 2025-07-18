import 'package:flutter/material.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/resources/live_offer_repository.dart';

class LiveOfferApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;

  LiveOfferApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> getLiveOffers() async {
    debugPrint(
      "LiveOfferApiProvider: getLiveOffers called with baseUrl: $baseUrl",
    );
    final uri = Uri.parse("$baseUrl/rider/active-promos/");

    return await apiProvider.get(uri, token: authRepository.accessToken);
  }
}
