import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/status.dart';
import '../cubit/view_problem_cubit.dart';
import '../widget/problem_deatils_widget.dart';

class ViewProblemScreen extends StatelessWidget {
  const ViewProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تفاصيل مشكلة (3)')),
      body: BlocBuilder<ViewProblemCubit, ViewProblemState>(
        builder: (context, state) {
          if (state.problemState == Status.loading) {
            return const CircularProgressIndicator();
          } else if (state.problemState == Status.error) {
            return Text('Error: ${state.problemError}');
          } else if (state.problemState == Status.success) {
            return ProblemDetailWidget(problem: state.problem!);
          } else {
            return const Text('No problem found');
          }
        },
      ),
    );
  }
}
