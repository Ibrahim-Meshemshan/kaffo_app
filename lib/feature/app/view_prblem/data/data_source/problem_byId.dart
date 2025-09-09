import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/api_manager/server_dio.dart';

import '../../../../../core/api_manager/api_constant.dart';
import '../../../problems/data/models/problems/problem_by_id_model.dart';

@singleton
class ProblemByIDDataSource {
  final Dio dio;
  ProblemByIDDataSource(this.dio);

  Future<ProblemByIdModel> getProblemById(int id) async {
    final response = await ServerDio.dioInstance.get(
      '${ApiConstant.baseUrl}problems/$id',
    );
    print("response is : ++++++++++++++++++++++++++++++++++++ ${response.data}");
    return ProblemByIdModel.fromJson(response.data);
  }
}
