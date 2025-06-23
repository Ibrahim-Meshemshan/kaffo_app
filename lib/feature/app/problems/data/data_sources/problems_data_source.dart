import 'package:injectable/injectable.dart';
import 'package:kaffo/core/api_manager/api_manager.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/data/models/user_id/user_response_dto.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';
import '../../../../../core/api_manager/api_execute.dart';
import '../models/addresses/address_id_dto.dart';

abstract class ProblemsDataSource {
  Future<Result<List<ProblemsContentEntity>>> fetchProblems();
  Future<Result<UserResponseDto>> fetchUsers(int userId);
  Future<Result<AddressIdDto>> fetchAddress(int addressId);
  // Future<Result<AddProblemResponseEntity>> addProblem(AddProblemRequest request);
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
  Future<Result<AddressIdDto>> fetchAddress(int addressId) async{
    return ApiExecute.executeApi<AddressIdDto>(() async{
      return await _apiClient.fetchAddress(addressId);
    },);
  }



  // @override
  // Future<Result<AddProblemResponseEntity>> addProblem(AddProblemRequest request) async{
  //   return ApiExecute.executeApi<AddProblemResponseEntity>(() async{
  //     return await _apiClient.addProblem({
  //       "title": request.title,
  //       "description":  request.description,
  //       "addressId": request.addressId,
  //       "categoryId": request.categoryId
  //     });
  //   },);
  // }


}
