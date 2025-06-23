part of 'problems_cubit.dart';

class ProblemsState {
  final Status problemState;
  final List<ProblemsContentEntity>? problemList;
  final String? problemError;

  final Map<int, UserResponseDto> usersMap;
  final Status userState;
  final String? userError;


  final Map<int, AddressIdDto> addressMap;
  final Status addressState;
  final String? addressError;


  ProblemsState({
    this.problemState = Status.initial,
    this.problemList,
    this.problemError,
    this.usersMap = const {},
    this.userState = Status.initial,
    this.userError,
    this.addressMap = const {},
    this.addressState = Status.initial,
    this.addressError,
  });

  ProblemsState copyWith({
    Status? problemState,
    List<ProblemsContentEntity>? problemList,
    String? problemError,
    Map<int, UserResponseDto>? usersMap,
    Status? userState,
    String? userError,
    Map<int, AddressIdDto>? addressMap,
    Status? addressState,
    String? addressError,
  }) {
    return ProblemsState(
      problemState: problemState ?? this.problemState,
      problemList: problemList ?? this.problemList,
      problemError: problemError ?? this.problemError,
      usersMap: usersMap ?? this.usersMap,
      userState: userState ?? this.userState,
      userError: userError ?? this.userError,
      addressMap: addressMap ?? this.addressMap,
      addressState: addressState ?? this.addressState,
      addressError: addressError ?? this.addressError,
    );
  }
}