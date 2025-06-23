import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/utils/status.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/address_use_case.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/problems_use_case.dart';
import '../../../../../core/models/result.dart';
import '../../data/models/addresses/address_id_dto.dart';
import '../../data/models/user_id/user_response_dto.dart';
import '../../domain/use_cases/user_use_case.dart';

part 'problems_state.dart';

@injectable
class ProblemsCubit extends Cubit<ProblemsState> {
  final ProblemsUseCase problemsUseCase;
  final UserUseCase userUseCase;
final AddressUseCase addressUseCase;
  ProblemsCubit({
    required this.problemsUseCase,
    required this.userUseCase,
    required this.addressUseCase
  }) : super(ProblemsState());

  Future<void> fetchProblems() async {
    emit(state.copyWith(problemState: Status.loading));
    Result<List<ProblemsContentEntity>> result = await problemsUseCase.call();
    switch (result) {
      case Success<List<ProblemsContentEntity>>():
        emit(
          state.copyWith(
            problemState: Status.success,
            problemList: result.data,
          ),
        );
      case Error<List<ProblemsContentEntity>>():
        emit(
          state.copyWith(
            problemState: Status.error,
            problemError: result.exception.toString(),
          ),
        );
    }
  }

  Future<void> fetchUser(int userId) async {
    if (state.usersMap[userId] == null) {
      Result<UserResponseDto> result = await userUseCase(userId);
      switch (result) {
        case Success<UserResponseDto>():
          emit(state.copyWith(
            usersMap: {...state.usersMap, userId: result.data!},
            userState: Status.success,
          ));
        case Error<UserResponseDto>():
          print("User fetch error for ID $userId: ${result.exception}");
          emit(state.copyWith(
            userState: Status.error,
            userError: result.exception.toString(),
          ));
      }
    }
  }



  Future<void> fetchAddress(int addressId) async {
    if (state.addressMap[addressId] == null) {
      Result<AddressIdDto> result = await addressUseCase(addressId);
      switch (result) {
        case Success<AddressIdDto>():
          emit(state.copyWith(
            addressMap: {...state.addressMap, addressId: result.data!},
            addressState: Status.success,
          ));
        case Error<AddressIdDto>():
          print("Address fetch error for ID $addressId: ${result.exception}");
          emit(state.copyWith(
            addressState: Status.error,
            addressError: result.exception.toString(),
          ));
      }
    }
  }
}












  //
  //
  // Future<void> addProblem(AddProblemRequest request) async {
  //   emit(state.copyWith(addProblemState: Status.loading));
  //
  //   Result<AddProblemResponseEntity> result = await addProblemUseCase.call(
  //       request);
  //
  //   switch (result) {
  //     case Success<AddProblemResponseEntity>():
  //       emit(state.copyWith(
  //           addProblemState: Status.success, addProblem: result.data));
  //     case Error<AddProblemResponseEntity>():
  //       emit(state.copyWith(problemState: Status.error,
  //           addProblemError: result.exception.toString()));
  //   }
  // }



