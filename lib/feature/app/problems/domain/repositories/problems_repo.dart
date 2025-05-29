import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/domain/entities/add_problem_request_entity.dart';
import 'package:kaffo/feature/app/problems/domain/entities/add_problem_response_entity.dart';

import '../entities/problems_response_entity.dart';

abstract class ProblemsRepo {
  Future<Result<List<ProblemsContentEntity>>> fetchProblems();
  Future<Result<AddProblemResponseEntity>> addProblem(AddProblemRequest request);
}
