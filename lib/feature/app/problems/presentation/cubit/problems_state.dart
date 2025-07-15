part of 'problems_cubit.dart';

class ProblemsState {
  final Status problemState;
  final List<ProblemsContentEntity>? problemList;
  final String? problemError;

  final Status citiesState;
  final List<CitiesModel>? citiesList;
  final String? citiesError;

  final Map<int, UserResponseDto> usersMap;
  final Status userState;
  final String? userError;


  final Map<int, AddressResponse> addressMap;
  final Status addressState;
  final String? addressError;

  final Status addProblemState;
  final String? addProblemError;
  final AddProblemResponse? addProblemResponse;

  final Status createProblemState;
  final ProblemsContentEntity? createProblemStateList;
  final String? createProblemStateError;

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
    this.addProblemState = Status.initial,
    this.addProblemError,
    this.addProblemResponse,
    this.createProblemState = Status.initial,
    this.createProblemStateList,
    this.createProblemStateError,
    this.citiesError,
    this.citiesState = Status.initial,
    this.citiesList
  });

  ProblemsState copyWith({
    Status? problemState,
    List<ProblemsContentEntity>? problemList,
    String? problemError,
    Status? citiesState,
    List<CitiesModel>? citiesList,
    String? citiesError,
    Map<int, UserResponseDto>? usersMap,
    Status? userState,
    String? userError,
    Map<int, AddressResponse>? addressMap,
    Status? addressState,
    String? addressError,
    Status? addProblemState,
    String? addProblemError,
    AddProblemResponse? addProblemResponse,
    Status? createProblemState,
    ProblemsContentEntity? createProblemStateList,
    String? createProblemStateError,
  }) {
    return ProblemsState(
      problemState: problemState ?? this.problemState,
      problemList: problemList ?? this.problemList,
      problemError: problemError ?? this.problemError,
      citiesState: citiesState ?? this.citiesState,
      citiesList: citiesList ?? this.citiesList,
      citiesError: citiesError ?? this.citiesError,
      usersMap: usersMap ?? this.usersMap,
      userState: userState ?? this.userState,
      userError: userError ?? this.userError,
      addressMap: addressMap ?? this.addressMap,
      addressState: addressState ?? this.addressState,
      addressError: addressError ?? this.addressError,
      addProblemState: addProblemState ?? this.addProblemState,
      addProblemError: addProblemError ?? this.addProblemError,
      addProblemResponse: addProblemResponse ?? this.addProblemResponse,
      createProblemState: createProblemState ?? this.createProblemState,
      createProblemStateList: createProblemStateList ??
          this.createProblemStateList,
      createProblemStateError: createProblemStateError ??
          this.createProblemStateError,
    );
  }

}