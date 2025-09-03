import 'package:flutter/material.dart';
import 'package:kaffo/core/routes_manager/route_generator.dart';
import 'package:kaffo/core/routes_manager/routes_names.dart';
import 'core/app_theme/app_theme.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/di/di.dart';
void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: RouteGenerator.generateRoutes,
      // initialRoute: RoutesNames.problems,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: ElevatedButton(onPressed: () {
      login();
    }, child: Text("Login")),);
  }

}
final FlutterAppAuth appAuth = FlutterAppAuth();
final storage = FlutterSecureStorage();

final String clientId = 'flutter-app';
final String redirectUrl = 'com.kaffo.app:/oauthredirect';
final String issuer = 'http://192.168.1.12:9098/realms/kafu-realm'; // still HTTP

Future<void> login() async {
  try {
    final result = await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        clientId,
        redirectUrl,
        discoveryUrl: '$issuer/.well-known/openid-configuration',
        scopes: ['openid', 'profile', 'email'],
      ),
    );

    if (result != null) {
      await storage.write(key: 'access_token', value: result.accessToken);
      print('Access Token: ${result.accessToken}');
    }
  } catch (e) {
    print('Login error: $e');
  }
}