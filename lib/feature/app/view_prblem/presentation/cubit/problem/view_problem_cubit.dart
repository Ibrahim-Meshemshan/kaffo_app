import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/models/result.dart';
import '../../../../../../core/utils/status.dart';
import '../../../../problems/data/models/problems/problem_by_id_model.dart';
import '../../../data/repo/problem_by_id_repo.dart';

part 'view_problem_state.dart';

@injectable
class ViewProblemCubit extends Cubit<ViewProblemState> {
  ViewProblemCubit(this._repo) : super(ViewProblemState());

  final ProblemByIdRepo _repo;

  Future<void> getProblemById(int id) async {
    // if (id <= 0) return;

    emit(state.copyWith(problemState: Status.loading));

    final result = await _repo.getProblemById(id);

    switch (result) {
      case ApiSuccessResult<ProblemByIdModel>():
        emit(
          state.copyWith(problem: result.data, problemState: Status.success),
        );
      case ApiErrorResult<ProblemByIdModel>():
        emit(
          state.copyWith(
            problemError: result.failures.toString(),
            problemState: Status.error,
          ),
        );
    }
  }
}
