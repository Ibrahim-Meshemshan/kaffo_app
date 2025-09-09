 import 'package:flutter/material.dart';
import 'package:kaffo/keycloak_auth_service.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: ()async {
        print("start");
        try {
          final tokens = await authService.login(
            username: "hekmat@gmail.com",
            password: "123456",
          );

          print("Access Token: ${tokens['access_token']}");
          print("Refresh Token: ${tokens['refresh_token']}");
          print("ID Token: ${tokens['id_token']}");
print("ddddddd");
print(tokens);
          // ✅ Save tokens securely (SharedPreferences, Hive, flutter_secure_storage)
        } catch (e) {
          print("Login failed: $e");
        }
        print("finish");
      }, child: Text("data")),),
    );
  }
}
final authService = KeycloakAuthService();

void loginUser() async {

}
