import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/domain/entities/user/user_response_entity.dart';

import '../../data/models/user_id/user_response_dto.dart';
import '../entities/problems_response_entity.dart';

abstract class ProblemsRepo {
  Future<Result<List<ProblemsContentEntity>>> fetchProblems();

  Future<Result<UserResponseDto>> fetchUsers(int userId);


  //  Future<Result<List<Category>>> fetchCategory();
  // Future<Result<AddProblemResponseEntity>> addProblem(AddProblemRequest request);
}
