import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/error_handler/failure.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/problem-category_response_model.dart';

import '../../../../../../core/models/result.dart';
import 'problem_category_data_source.dart';

@injectable
class ProblemCategoryRepository {
  ProblemCategoryRepository(this._dataSource);

  final ProblemCategoryDataSource _dataSource;

  Future<ApiResult<CategoryResponseModel>> getProblemCategory() async {
    try {
      final response = await _dataSource.getProblemCategory();
      return ApiSuccessResult(response);
    } on DioException catch (errorMessage) {
      return ApiErrorResult(errorMessage as Failures);
    }
  }
}
