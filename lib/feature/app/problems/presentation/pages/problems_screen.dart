import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_colors/colors.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/utils/status.dart';
import '../../../../../core/widgets/main_scaffold.dart';
import '../cubit/problems_cubit.dart';
import '../widgets/problem_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProblemsScreen extends StatelessWidget {
  const ProblemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: AppLocalizations.of(context)!.problems,
      body: BlocProvider(
      create: (context) => getIt<ProblemsCubit>()..fetchProblems(),
      child: BlocBuilder<ProblemsCubit, ProblemsState>(
        builder: (context, state) {
          debugPrint('Current ProblemsState: ${state.problemState}');
          if (state.problemState == Status.loading) {
            debugPrint('ProblemsScreen: Displaying Loading state.');
            return Center(
              child: CircularProgressIndicator(color: AppColors.black,),);
          } else if (state.problemState == Status.error) {
            return Center(child: Text(state.problemError.toString()),);
          } else if (state.problemState == Status.success) {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: state.problemList!.length,
              itemBuilder: (context, index) {
                final problem = state.problemList![index];
                return ProblemCardWidget(problem: problem);
              },
            );
          }
          return SizedBox();
        },
      ),
    ),);
  }
}
