part of 'problems_cubit.dart';

class ProblemsState {
  final Status problemState;
  final List<ProblemsContentEntity>? problemList;
  final String? problemError;
  final Map<int, UserResponseDto> usersMap;
  final Status userState;
  final String? userError;

  ProblemsState({
    this.problemState = Status.initial,
    this.problemList,
    this.problemError,
    this.usersMap = const {},
    this.userState = Status.initial,
    this.userError,
  });

  ProblemsState copyWith({
    Status? problemState,
    List<ProblemsContentEntity>? problemList,
    String? problemError,
    Map<int, UserResponseDto>? usersMap,
    Status? userState,
    String? userError,
  }) {
    return ProblemsState(
      problemState: problemState ?? this.problemState,
      problemList: problemList ?? this.problemList,
      problemError: problemError ?? this.problemError,
      usersMap: usersMap ?? this.usersMap,
      userState: userState ?? this.userState,
      userError: userError ?? this.userError,
    );
  }
}