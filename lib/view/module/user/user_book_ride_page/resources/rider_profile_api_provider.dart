import 'package:flutter/material.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';

class RiderProfileApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;

  RiderProfileApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> getRiderProfile() async {
    final uri = Uri.parse("$baseUrl/rider/rider-profile/");

    return await apiProvider.get(uri, token: authRepository.accessToken);
  }
}
