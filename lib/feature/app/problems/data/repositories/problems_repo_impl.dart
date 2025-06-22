import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/data/data_sources/problems_data_source.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';
import 'package:kaffo/feature/app/problems/domain/entities/user/user_response_entity.dart';
import 'package:kaffo/feature/app/problems/domain/repositories/problems_repo.dart';

import '../../../../../core/error_handler/exception_impl.dart';
import '../models/user_id/user_response_dto.dart';


@Injectable(as: ProblemsRepo)
class ProblemsRepoImpl implements ProblemsRepo {
  ProblemsDataSource dataSource;
  ProblemsRepoImpl({required this.dataSource});


  @override
  Future<Result<List<ProblemsContentEntity>>> fetchProblems() async{
    try {
      return await dataSource.fetchProblems();
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }

  @override
  Future<Result<UserResponseDto>> fetchUsers(int userId) async{
    try {
      return await dataSource.fetchUsers(userId);
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }

  // @override
  // Future<Result<AddProblemResponseEntity>> addProblem(AddProblemRequest request) async{
  //   try {
  //     return await dataSource.addProblem(request);
  //   } on DioException catch (ex) {
  //     return Error(ClientError(errorModel: ex.response?.data));
  //   }
  // }

}

