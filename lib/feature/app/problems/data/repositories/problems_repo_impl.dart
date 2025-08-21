import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/data/data_sources/problems_data_source.dart';
import 'package:kaffo/feature/app/problems/data/models/addresses/address_response.dart';
import 'package:kaffo/feature/app/problems/data/models/cities/cities_model.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/add_problem_response.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/problem_by_id_model.dart';
import 'package:kaffo/feature/app/problems/domain/entities/address/address_request.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problem/problems_content_entity.dart';
import 'package:kaffo/feature/app/problems/domain/repositories/problems_repo.dart';
import '../../../../../core/error_handler/exception_impl.dart';
import '../../domain/entities/problem/add_problem_request.dart';
import '../models/user_id/user_response_dto.dart';


@Injectable(as: ProblemsRepo)
class ProblemsRepoImpl implements ProblemsRepo {
 final ProblemsDataSource _dataSource;
  ProblemsRepoImpl( this._dataSource);


  @override
  Future<Result<List<ProblemsContentEntity>>> fetchProblems() async{
    try {
      return await _dataSource.fetchProblems();
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }

  @override
  Future<Result<UserResponseDto>> fetchUsers(int userId) async{
    try {
      return await _dataSource.fetchUsers(userId);
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }

  @override
  Future<Result<AddressResponse>> fetchAddress(int addressId) async {
    try {
      return await _dataSource.fetchAddress(addressId);
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }

 @override
 Future<Result<AddProblemResponse>> addProblem(
     AddProblemRequest request) async {
   try {
     return await _dataSource.addProblem(request);
   } on DioException catch (ex) {
     return Error(ClientError(errorModel: ex.response?.data));
   }
 }

 @override
 Future<Result<AddressResponse>> createAddress(AddressRequest request) async {
   try {
     return await _dataSource.createAddress(request);
   } on DioException catch (ex) {
     return Error(ClientError(errorModel: ex.response?.data));
   }
 }

  @override
  Future<Result<List<CitiesModel>>> fetchCities() async{
    try {
      return await _dataSource.fetchCities();
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }

  @override
  Future<Result<ProblemByIdModel>> fetchProblemById(int problemId) async{
    try {
      return await _dataSource.fetchProblemById(problemId);
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }

}

