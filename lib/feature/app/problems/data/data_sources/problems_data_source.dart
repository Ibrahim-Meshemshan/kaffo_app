import 'package:injectable/injectable.dart';
import 'package:kaffo/core/api_manager/api_manager.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/data/models/cities/cities_model.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/problem_by_id_model.dart';
import 'package:kaffo/feature/app/problems/data/models/user_id/user_response_dto.dart';
import 'package:kaffo/feature/app/problems/domain/entities/address/address_request.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problem/problems_content_entity.dart';

import '../../../../../core/api_manager/api_execute.dart';
import '../../domain/entities/problem/add_problem_request.dart';
import '../models/addresses/address_response.dart';
import '../models/problems/add_problem_response.dart';

abstract class ProblemsDataSource {
  Future<Result<List<ProblemsContentEntity>>> fetchProblems();
  Future<Result<UserResponseDto>> fetchUsers(int userId);
  Future<Result<AddressResponse>> fetchAddress(int addressId);

  Future<Result<ProblemByIdModel>> fetchProblemById(int problemId);
  Future<Result<AddProblemResponse>> addProblem(AddProblemRequest request);
  Future<Result<AddressResponse>> createAddress(AddressRequest request);
  Future<Result<List<CitiesModel>>> fetchCities();
}

@Injectable(as: ProblemsDataSource)
class ProblemsDataSourceImpl implements ProblemsDataSource {
  final RestClient _apiClient;
  ProblemsDataSourceImpl( this._apiClient);

  @override
  Future<Result<List<ProblemsContentEntity>>> fetchProblems() {
    return ApiExecute.executeApi<List<ProblemsContentEntity>>(() async{
      final response = await _apiClient.fetchProblems();
      return response.content?.map((dto) => dto.toEntity()).toList() ?? [];
    },);
  }

  @override
  Future<Result<UserResponseDto>> fetchUsers(int userId) async{
    return ApiExecute.executeApi<UserResponseDto>(() async{
      return await _apiClient.fetchUsers(userId);
    },);
  }

  @override
  Future<Result<AddressResponse>> fetchAddress(int addressId) async{
    return ApiExecute.executeApi<AddressResponse>(() async{
      return await _apiClient.fetchAddress(addressId);
    },);
  }

  @override
  Future<Result<AddProblemResponse>> addProblem(AddProblemRequest request) async{
    return ApiExecute.executeApi<AddProblemResponse>(() async{
      return await _apiClient.addProblem(request);
    },);
  }

  @override
  Future<Result<AddressResponse>> createAddress(AddressRequest request) async{
    return ApiExecute.executeApi<AddressResponse>(() async{
      return await _apiClient.createAddress(request);
    },);
  }

  @override
  Future<Result<List<CitiesModel>>> fetchCities() {
    return ApiExecute.executeApi<List<CitiesModel>>(() async{
      return await _apiClient.fetchCities();

    },);
  }

  @override
  Future<Result<ProblemByIdModel>> fetchProblemById(int problemId) {
    return ApiExecute.executeApi<ProblemByIdModel>(() async{
      return await _apiClient.fetchProblemById(problemId);
    },);
  }


}
