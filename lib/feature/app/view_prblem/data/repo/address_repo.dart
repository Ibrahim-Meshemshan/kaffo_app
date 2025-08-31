// address_repo.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/feature/app/problems/data/models/addresses/address_response.dart';
import 'package:kaffo/feature/app/problems/data/models/cities/cities_model.dart';

import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/models/result.dart';
import '../data_source/address_data_source.dart';

@injectable
class AddressRepo {
  final AddressDataSource _dataSource;

  AddressRepo(this._dataSource);

  Future<ApiResult<AddressResponse>> getAddressById(int id) async {
    try {
      final response = await _dataSource.getAddressById(id);
      return ApiSuccessResult(response);
    } on DioException catch (error) {
      return ApiErrorResult(
        ServerError(errorMessage: error.message ?? ''),
      );
    }
  }


  Future<ApiResult<List<CitiesModel>>> getCities() async {
    try {
      final response = await _dataSource.getCities();
      return ApiSuccessResult(response);
    } on DioException catch (error) {
      return ApiErrorResult(ServerError(errorMessage: error.message ?? ''),
      );
    }
  }
}
