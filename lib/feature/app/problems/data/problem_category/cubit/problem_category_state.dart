part of 'problem_category_cubit.dart';


class ProblemCategoryState {


  final Status problemCategoryState;
  final String? problemCategoryError;
  final CategoryResponseModel? problemCategoryList;

  const ProblemCategoryState({
    this.problemCategoryState = Status.initial,
    this.problemCategoryError,
    this.problemCategoryList,
  });

  ProblemCategoryState copyWith({
    Status? problemCategoryState,
    String? problemCategoryError,
    CategoryResponseModel? problemCategoryList,
  }) {
    return ProblemCategoryState(
      problemCategoryState: problemCategoryState ?? this.problemCategoryState,
      problemCategoryError: problemCategoryError ?? this.problemCategoryError,
      problemCategoryList: problemCategoryList ?? this.problemCategoryList,
    );
  }

}


