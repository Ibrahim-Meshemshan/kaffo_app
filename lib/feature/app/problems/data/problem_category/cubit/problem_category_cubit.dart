import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/models/result.dart';
import '../../../../../../core/utils/status.dart';
import '../../models/problems/problem-category_response_model.dart';
import '../data/problem_category_repository.dart';

part 'problem_category_state.dart';


@injectable
class ProblemCategoryCubit extends Cubit<ProblemCategoryState> {
  ProblemCategoryCubit(this._repository) : super(ProblemCategoryState());

  final ProblemCategoryRepository _repository;


  Future<void> getProblemCategory() async {
    emit(state.copyWith(problemCategoryState: Status.loading));
    final result = await _repository.getProblemCategory();
    switch (result) {
      case ApiSuccessResult<CategoryResponseModel>():
        emit(
          state.copyWith(problemCategoryList: result.data, problemCategoryState: Status.success),
        );

      case ApiErrorResult<CategoryResponseModel>():
        emit(
          state.copyWith(
            problemCategoryError: result.failures.errorMessage.toString(),
            problemCategoryState: Status.error,
          ),
        );
    }

  }
}
