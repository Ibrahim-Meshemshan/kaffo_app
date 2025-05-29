import 'package:flutter/material.dart';
import 'package:kaffo/core/routes_manager/route_generator.dart';
import 'package:kaffo/core/routes_manager/routes_names.dart';
import 'core/app_theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: RouteGenerator.generateRoutes,
      initialRoute: RoutesNames.problems,
    );
  }
}
