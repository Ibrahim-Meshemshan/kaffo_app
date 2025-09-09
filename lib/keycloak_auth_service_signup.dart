import 'package:dio/dio.dart';

class KeycloakAdminService {
  final Dio _dio = Dio();

  KeycloakAdminService() {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  final String _baseUrl = "http://192.168.1.3:9098"; // emulator → localhost

  /// 1. Get admin token
  Future<String> getAdminToken({
    required String username,
    required String password,
  }) async {
    final String url = "$_baseUrl/realms/master/protocol/openid-connect/token";

    final response = await _dio.post(
      url,
      data: {
        "client_id": "admin-cli",
        "grant_type": "password",
        "username": username,
        "password": password,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Accept": "application/json"},
      ),
    );

    return response.data["access_token"];
  }

  /// 2. Create a new user
  Future<void> createUser({
    required String adminToken,
    required String username,
    required String email,
    required String password,
    String firstName = "",
    String lastName = "",
  }) async {
    final String url = "$_baseUrl/admin/realms/kafu-realm/users";

    final response = await _dio.post(
      url,
      data: {
        "username": username,
        "email": email,
        "enabled": true,
        "firstName": firstName,
        "lastName": lastName,
        "credentials": [
          {
            "type": "password",
            "value": password,
            "temporary": false
          }
        ]
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $adminToken",
          "Content-Type": "application/json"
        },
      ),
    );
    print(response.data);
print("Dasdas");
    if (response.statusCode == 201) {
      print("✅ User created successfully");
      print(response);
    } else {
      throw Exception("❌ Failed to create user: ${response.data}");
    }
  }
}
