import 'package:flutter/material.dart';
import 'package:kaffo/keycloak_auth_service_signup.dart';

final adminService = KeycloakAdminService();
class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: ()async {
        print("start");
        try {
          print("🔑 Getting admin token...");
          final adminToken = await adminService.getAdminToken(
            username: "admin",
            password: "admin",
          );

          print("🆕 Creating new user...");
          await adminService.createUser(
            adminToken: adminToken,
            username: "testuser",
            email: "testusdasedasdr@example.com",
            password: "password123",
            firstName: "Test",
            lastName: "User",
          );

          print("🎉 User created!");
        } catch (e) {
          print("⚠️ Sign-up failed: $e");
        }
        print("finish");
      }, child: Text("data")),),
    );
  }
}
Future<void> signUpUser() async {
  try {
    print("🔑 Getting admin token...");
    final adminToken = await adminService.getAdminToken(
      username: "admin",
      password: "your-admin-password",
    );

    print("🆕 Creating new user...");
    await adminService.createUser(
      adminToken: adminToken,
      username: "testuser",
      email: "testuser@example.com",
      password: "password123",
      firstName: "Test",
      lastName: "User",
    );

    print("🎉 User created!");
  } catch (e) {
    print("⚠️ Sign-up failed: $e");
  }
}
