import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/utils/status.dart';
import 'package:kaffo/feature/app/problems/domain/entities/add_problem_request_entity.dart';
import 'package:kaffo/feature/app/problems/domain/entities/add_problem_response_entity.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/add_problem_use_case.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/problems_use_case.dart';

import '../../../../../core/models/result.dart';

part 'problems_state.dart';

@injectable
class ProblemsCubit extends Cubit<ProblemsState> {
  ProblemsCubit(
      {required this.problemsUseCase, required this.addProblemUseCase})
      : super(ProblemsState());

  ProblemsUseCase problemsUseCase;
  AddProblemUseCase addProblemUseCase;

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


  Future<void> addProblem(AddProblemRequest request) async {
    emit(state.copyWith(addProblemState: Status.loading));

    Result<AddProblemResponseEntity> result = await addProblemUseCase.call(
        request);

    switch (result) {
      case Success<AddProblemResponseEntity>():
        emit(state.copyWith(
            addProblemState: Status.success, addProblem: result.data));
      case Error<AddProblemResponseEntity>():
        emit(state.copyWith(problemState: Status.error,
            addProblemError: result.exception.toString()));
    }
  }
}
