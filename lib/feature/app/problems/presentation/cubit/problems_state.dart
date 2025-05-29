part of 'problems_cubit.dart';

class ProblemsState {
  final Status? problemState;
  final String? problemError;
  final List<ProblemsContentEntity>? problemList;

  const ProblemsState({
    this.problemState = Status.initial,
    this.problemError,
    this.problemList,
  });

  ProblemsState copyWith({
    Status? problemState,
    String? problemError,
    List<ProblemsContentEntity>? problemList,
  }) {
    return ProblemsState(
      problemState: problemState ?? this.problemState,
      problemError: problemError ?? this.problemError,
      problemList: problemList ?? this.problemList,
    );
  }
}


