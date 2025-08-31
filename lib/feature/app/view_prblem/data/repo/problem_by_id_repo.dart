import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/models/result.dart';
import '../../../problems/data/models/problems/problem_by_id_model.dart';
import '../data_source/problem_byId.dart';

@injectable
class ProblemByIdRepo {
  final ProblemByIDDataSource _dataSource;

  ProblemByIdRepo(this._dataSource);

  Future<ApiResult<ProblemByIdModel>> getProblemById(int id) async {
    try {
      final response = await _dataSource.getProblemById(id);

      return ApiSuccessResult(response);
    } on DioException catch (error) {
      return ApiErrorResult(ServerError(errorMessage: error.message ?? ''),
      );
    }
  }
}