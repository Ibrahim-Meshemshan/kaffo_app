import 'package:injectable/injectable.dart';
import 'package:kaffo/core/api_manager/api_manager.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/domain/entities/add_problem_request_entity.dart';
import 'package:kaffo/feature/app/problems/domain/entities/add_problem_response_entity.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';

import '../../../../../core/api_manager/api_execute.dart';

abstract class ProblemsDataSource {
  Future<Result<List<ProblemsContentEntity>>> fetchProblems();
  Future<Result<AddProblemResponseEntity>> addProblem(AddProblemRequest request);
}

@Injectable(as: ProblemsDataSource)
class ProblemsDataSourceImpl implements ProblemsDataSource {
  RestClient apiClient;
  ProblemsDataSourceImpl({required this.apiClient});

  @override
  Future<Result<List<ProblemsContentEntity>>> fetchProblems() async{
    return ApiExecute.executeApi<List<ProblemsContentEntity>>(() async{
      return await apiClient.fetchProblems();
    },);
  }

  @override
  Future<Result<AddProblemResponseEntity>> addProblem(AddProblemRequest request) async{
    return ApiExecute.executeApi<AddProblemResponseEntity>(() async{
      return await apiClient.addProblem({
        "title": request.title,
        "description":  request.description,
        "addressId": request.addressId,
        "categoryId": request.categoryId
      });
    },);
  }
}
