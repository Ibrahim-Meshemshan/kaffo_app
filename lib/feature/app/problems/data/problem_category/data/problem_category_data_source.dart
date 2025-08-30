
import 'package:injectable/injectable.dart';

import '../../../../../../core/api_manager/server_dio.dart';
import '../../models/problems/problem-category_response_model.dart';

@singleton
class ProblemCategoryDataSource {
  Future<ProblemCategoryResponseModel> getProblemCategory() async {
    final response = await ServerDio.dioInstance.get(
        'problem-categories'
    );
    return ProblemCategoryResponseModel.fromJson(response.data);
  }
}