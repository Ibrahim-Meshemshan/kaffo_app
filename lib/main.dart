import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaffo/core/api_manager/server_dio.dart';
import 'package:kaffo/core/routes_manager/route_generator.dart';
import 'package:kaffo/core/routes_manager/routes_names.dart';
import 'package:kaffo/feature/app/problems/presentation/cubit/problems_cubit.dart';
import 'core/app_theme/app_theme.dart';

import 'core/di/di.dart';
import 'core/storage/sharedprfrences_helper.dart';

void main() async{
  configureDependencies();
  ServerDio.initDio();
  // SharedPreferencesHelper.init();
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
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: "Cairo",
        ),
      ),
      onGenerateRoute: RouteGenerator.generateRoutes,
      // initialRoute: RoutesNames.problems,
    );
  }
}

