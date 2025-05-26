import 'package:flutter/material.dart';
import 'package:kaffo/core/routes_manager/route_generator.dart';

import 'core/app_theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: RouteGenerator.generateRoutes,
    );
  }
}
