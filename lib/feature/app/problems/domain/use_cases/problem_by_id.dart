import 'package:injectable/injectable.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/problem_by_id_model.dart';

import '../../../../../core/models/result.dart';
import '../repositories/problems_repo.dart';

@injectable
class ProblemByIdUseCase {
  final ProblemsRepo _repo;

  ProblemByIdUseCase(this._repo);

  Future<ApiResult<ProblemByIdModel>> call(int problemId) async {
    return await _repo.fetchProblemById(problemId);
  }
}
