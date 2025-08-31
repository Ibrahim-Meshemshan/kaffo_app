import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/models/result.dart';
import '../../../problems/data/models/problems/problem-category_response_model.dart';
import '../data_source/category_data_source.dart';

@injectable
class CategoryRepo {
  final CategoryDataSource _dataSource;

  CategoryRepo(this._dataSource);

  Future<ApiResult<CategoryResponseModel>> getCategoryById(
      int id) async {
    try {
      final response = await _dataSource.getCategoryById(id);
      return ApiSuccessResult(response);
    } on DioException catch (error) {
      return ApiErrorResult(ServerError(errorMessage: error.message ?? ''),
      );
    }
  }
}