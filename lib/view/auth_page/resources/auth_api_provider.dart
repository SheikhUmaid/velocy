import 'package:dio/dio.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';

class AuthApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  AuthApiProvider({required this.baseUrl, required this.apiProvider});

  Future<dynamic> register({required Map<String, String> body}) async {
    final uri = "$baseUrl/auth_api/register/";

    return await apiProvider.post(uri, body);
  }

  Future<dynamic> login({required Map<String, String> body}) async {
    final uri = "$baseUrl/auth_api/login/";

    return await apiProvider.post(uri, body);
  }

  Future<dynamic> logout({
    required Map<String, dynamic> body,
    required String token,
  }) async {
    final uri = "$baseUrl/auth/farmer-logout";
    return await apiProvider.post(uri, body, token: token);
  }

  // Future<void> profileComplete(FormData formData) async {
  //   await apiProvider.post(
  //     '/your-endpoint-here',
  //     data: formData,
  //     options: Options(contentType: 'multipart/form-data'),
  //   );
  // }
  // Future<void> profileComplete(FormData formData, String token) async {
  //   final uri = "$baseUrl/update-profile/";
  //   return await apiProvider.post(url, formData)
  // }

  Future<dynamic> updateProfile({
    required FormData body,
    required String token,
  }) async {
    final uri = "$baseUrl/auth_api/profile-setup/";

    return await apiProvider.put(uri, body, token: token, userId: '');
  }
}
