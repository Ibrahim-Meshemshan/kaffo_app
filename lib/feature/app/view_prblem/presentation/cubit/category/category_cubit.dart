import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/problem-category_response_model.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/models/result.dart';
import '../../../../../../core/utils/status.dart';
import '../../../data/repo/category_repo.dart';

part 'category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo _repo;

  CategoryCubit(this._repo) : super(const CategoryState());

  Future<void> getCategoryById(int id) async {
    if (id <= 0) return;

    emit(state.copyWith(categoryState: Status.loading));

    final result = await _repo.getCategoryById(id);

    switch (result) {
      case ApiSuccessResult<CategoryResponseModel>():
        emit(
          state.copyWith(
            category: result.data,
            categoryState: Status.success,
          ),
        );
      case ApiErrorResult<CategoryResponseModel>():
        emit(
          state.copyWith(
            categoryError: result.failures.toString(),
            categoryState: Status.error,
          ),
        );
    }
  }
}