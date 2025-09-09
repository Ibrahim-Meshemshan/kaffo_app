import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaffo/core/routes_manager/routes_names.dart';
import 'package:kaffo/feature/app/myComplaints/presentation/pages/my_complaints.dart';
import 'package:kaffo/feature/app/myContributions/presentation/pages/my_contributions.dart';
import 'package:kaffo/feature/app/myDonations/presentation/pages/my_donations.dart';
import 'package:kaffo/feature/app/myVolunteering/presentation/pages/my_volunteering.dart';
import 'package:kaffo/feature/app/problems/presentation/pages/problems_screen.dart';
import 'package:kaffo/feature/app/statistics/presentation/pages/statistics_screen.dart';
import 'package:kaffo/feature/app/view_prblem/presentation/pages/view_problem_screen.dart';
import 'package:kaffo/feature/app/volunteering/presentation/pages/volunteering_screen.dart';
import 'package:kaffo/feature/auth/logout/presentation/pages/logout_screen.dart';

import '../../feature/app/home/presentation/pages/home_body_screen.dart';
import '../../feature/app/view_prblem/presentation/cubit/address/address_cubit.dart';
import '../../feature/app/view_prblem/presentation/cubit/category/category_cubit.dart';
import '../../feature/app/view_prblem/presentation/cubit/photo/photo_cubit.dart';
import '../../feature/app/view_prblem/presentation/cubit/problem/view_problem_cubit.dart';
import '../di/di.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.homeBody:
        return MaterialPageRoute(builder: (context) => HomeBodyScreen());
      case RoutesNames.problems:
        return MaterialPageRoute(builder: (context) => ProblemsScreen());
      case RoutesNames.volunteer:
        return MaterialPageRoute(builder: (context) => VolunteeringScreen());
      case RoutesNames.statistics:
        return MaterialPageRoute(builder: (context) => StatisticsScreen());
      case RoutesNames.myComplaints:
        return MaterialPageRoute(builder: (context) => MyComplaintsScreen());
      case RoutesNames.myVolunteering:
        return MaterialPageRoute(builder: (context) => MyVolunteeringScreen());
      case RoutesNames.myContributions:
        return MaterialPageRoute(builder: (context) => MyContributionsScreen());
      case RoutesNames.myDonations:
        return MaterialPageRoute(builder: (context) => MyDonationsScreen());

      case RoutesNames.viewProblemScreen:
        final problemId = settings.arguments as int; // Get problemId from arguments or default to 1
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<ViewProblemCubit>()), //
              BlocProvider(create: (context) => getIt<AddressCubit>()),
              BlocProvider(create: (context) => getIt<CategoryCubit>()),
              BlocProvider(create: (context) => getIt<PhotoCubit>()),
              // BlocProvider(create: (context) => getIt<UploadCubit>()),
            ],
            child: ViewProblemScreen(problemId: problemId),
          ),
        );


      case RoutesNames.logout:
        return MaterialPageRoute(builder: (context) => LogoutScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                appBar: AppBar(title: const Text('No Route Found')),
                body: const Center(child: Text('No Route Found')),
              ),
        );
    }
  }
}
