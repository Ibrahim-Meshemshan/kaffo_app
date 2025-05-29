import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/utils/status.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/problems_use_case.dart';

import '../../../../../core/models/result.dart';

part 'problems_state.dart';

@injectable
class ProblemsCubit extends Cubit<ProblemsState> {
  ProblemsCubit({required this.problemsUseCase}) : super(ProblemsState());

  ProblemsUseCase problemsUseCase;

  void fetchProblems()async{
    debugPrint('ProblemCubit: fetchProblems called.');
    emit(state.copyWith(problemState: Status.loading));
    debugPrint('ProblemCubit: Emitted Loading state.');
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
}
