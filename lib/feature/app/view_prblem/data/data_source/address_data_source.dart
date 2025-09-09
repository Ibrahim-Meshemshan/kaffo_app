// address_data_source.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api_manager/server_dio.dart';
import '../../../../../core/api_manager/api_constant.dart';
import '../../../problems/data/models/addresses/address_response.dart';
import '../../../problems/data/models/cities/cities_model.dart';

@singleton
class AddressDataSource {
  final Dio dio;

  AddressDataSource(this.dio);

  Future<AddressResponse> getAddressById(int id) async {
    final response = await ServerDio.dioInstance.get(
      '${ApiConstant.baseUrl}addresses/$id',
    );
    return AddressResponse.fromJson(response.data);
  }

  Future<List<CitiesModel>> getCities() async {
    final response = await dio.get(
      '${ApiConstant.baseUrl}addresses/cities',
    );
    return (response.data as List)
        .map((city) => CitiesModel.fromJson(city))
        .toList();
  }
}