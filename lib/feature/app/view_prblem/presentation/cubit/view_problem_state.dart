part of 'view_problem_cubit.dart';

class ViewProblemState {
  final Status problemState;
  final String? problemError;
  final ProblemByIdModel? problem;

  const ViewProblemState({
    this.problemState = Status.initial,
    this.problemError,
    this.problem,
  });

  ViewProblemState copyWith({
    Status? problemState,
    String? problemError,
    ProblemByIdModel? problem,
  }) {
    return ViewProblemState(
      problemState: problemState ?? this.problemState,
      problemError: problemError ?? this.problemError,
      problem: problem ?? this.problem,
    );
  }
}
