// category_data_source.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/problem-category_response_model.dart';

import '../../../../../core/api_manager/server_dio.dart';
import '../../../../../core/app_consts/api_constant.dart';

@singleton
class CategoryDataSource {
  final Dio dio;

  CategoryDataSource(this.dio);

  Future<CategoryResponseModel> getCategoryById(int id) async {
    final response = await ServerDio.dioInstance.get(
      '${ApiConstant.baseUrl}problem-categories/$id',
    );
    return CategoryResponseModel.fromJson(response.data);
  }
}