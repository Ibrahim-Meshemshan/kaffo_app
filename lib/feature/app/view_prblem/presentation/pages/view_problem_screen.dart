import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/status.dart';
import '../cubit/problem/view_problem_cubit.dart';
import '../widget/problem_deatils_widget.dart';

class ViewProblemScreen extends StatefulWidget {
  final int problemId;

  const ViewProblemScreen({super.key, required this.problemId});

  @override
  State<ViewProblemScreen> createState() => _ViewProblemScreenState();
}

class _ViewProblemScreenState extends State<ViewProblemScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ViewProblemCubit>().getProblemById(widget.problemId);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ViewProblemCubit, ViewProblemState>(
        builder: (context, state) {
          if (state.problemState == Status.loading) {
            return Center(child: const CircularProgressIndicator());
          } else if (state.problemState == Status.error) {
            return Center(child: Text('Error: ${state.problemError}'));
          } else if (state.problemState == Status.success) {
            return Directionality(
                textDirection: TextDirection.rtl,
                child: ProblemDetailWidget(problem: state.problem!));
          } else {
            return const Text('No problem found');
          }
        },
      ),
    );
  }
}
