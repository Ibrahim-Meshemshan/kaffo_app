import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaffo/feature/app/problems/presentation/widgets/add_problem_widget.dart';

import '../../../../../core/app_colors/colors.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/utils/status.dart';
import '../../../../../core/widgets/main_scaffold.dart';
import '../cubit/problems_cubit.dart';
import '../widgets/problem_card_widget.dart';

class ProblemsScreen extends StatelessWidget {
  const ProblemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'المشاكل',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const AddProblemWidget(),
            BlocProvider(
              create: (context) => getIt<ProblemsCubit>()..fetchProblems(),
              child: BlocConsumer<ProblemsCubit, ProblemsState>(
                listener: (context, state) {

                },
                builder: (context, state) {
                  if (state.problemState == Status.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.black,
                      ),
                    );
                  } else if (state.problemState == Status.error) {
                    return Center(
                      child: Text(state.problemError ?? 'problem error'),
                    );
                  } else if (state.problemState == Status.success) {
                    if (state.problemList == null || state.problemList!.isEmpty) {
                      return const Center(
                        child: Text('لا توجد مشاكل متاحة حالياً'),
                      );
                    }

                    return Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: state.problemList!.length,
                        itemBuilder: (context, index) {
                          final problem = state.problemList![index];
                          return ProblemCardWidget(problem: problem);
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}