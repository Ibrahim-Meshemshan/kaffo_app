part of 'problems_cubit.dart';

class ProblemsState {
  final Status? problemState;
  final String? problemError;
  final List<ProblemsContentEntity>? problemList;

  final Status? addProblemState;
  final String? addProblemError;
  final AddProblemResponseEntity? addProblem;

  const ProblemsState({
    this.addProblemState = Status.initial,
    this.addProblemError,
    this.addProblem,
    this.problemState = Status.initial,
    this.problemError,
    this.problemList,
  });

  ProblemsState copyWith({
    Status? problemState,
    String? problemError,
    List<ProblemsContentEntity>? problemList,
    Status? addProblemState,
    String? addProblemError,
    AddProblemResponseEntity? addProblem,
  }) {
    return ProblemsState(
      problemState: problemState ?? this.problemState,
      problemError: problemError ?? this.problemError,
      problemList: problemList ?? this.problemList,
      addProblemState: addProblemState ?? this.addProblemState,
      addProblemError: addProblemError ?? this.addProblemError,
      addProblem: addProblem ?? this.addProblem,
    );
  }
}


