import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaffo/core/routes_manager/route_generator.dart';
import 'package:kaffo/core/routes_manager/routes_names.dart';
import 'package:kaffo/feature/app/problems/presentation/cubit/problems_cubit.dart';
import 'package:kaffo/feature/auth/login/presentation/view/change_password_screen.dart';
import 'package:kaffo/feature/auth/login/presentation/view/login_screen.dart';
import 'package:kaffo/feature/auth/login/presentation/view/signup_screen.dart';
import 'package:kaffo/login.dart';
import 'package:kaffo/signup.dart';
import 'core/app_theme/app_theme.dart';
import 'package:kaffo/l10n/app_localizations.dart';

import 'core/di/di.dart';

void main() {
  configureDependencies();
  runApp(BlocProvider(
    create: (context) => getIt<ProblemsCubit>(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('ar'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: RouteGenerator.generateRoutes,
      initialRoute: RoutesNames.problems,
      // home: SignupScreen(),
    );
  }
}

