part of 'category_cubit.dart';

class CategoryState {
  final Status categoryState;
  final String? categoryError;
  final CategoryResponseModel? category;

  const CategoryState({
    this.categoryState = Status.initial,
    this.categoryError,
    this.category,
  });

  CategoryState copyWith({
    Status? categoryState,
    String? categoryError,
    CategoryResponseModel? category,
  }) {
    return CategoryState(
      categoryState: categoryState ?? this.categoryState,
      categoryError: categoryError ?? this.categoryError,
      category: category ?? this.category,
    );
  }
}
