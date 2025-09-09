import 'package:dio/dio.dart';

class KeycloakAuthService {
  final Dio _dio = Dio();

  final String _baseUrl = "http://192.168.1.3:9098"; // use 10.0.2.2 for Android emulator

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final String url =
        "$_baseUrl/realms/kafu-realm/protocol/openid-connect/token";

    try {
      final response = await _dio.post(
        url,
        data: {
          "grant_type": "password",
          "client_id": "flutter-app",
          "scope": "openid email",
          "username": username,
          "password": password,
        },
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        // Response contains access token, refresh token, etc.
        print("aaaaaaaaaaaaaa");
        print(response);
        return response.data;
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Login error: ${e.response?.data ?? e.message}");
    }
  }
}

//{
//     "error": "invalid_grant",
//     "error_description": "Invalid user credentials"
// }