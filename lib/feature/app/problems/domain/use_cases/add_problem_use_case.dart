import 'package:injectable/injectable.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/add_problem_response.dart';
import '../../../../../core/models/result.dart';
import '../entities/problem/add_problem_request.dart';
import '../repositories/problems_repo.dart';

@injectable
class AddProblemUseCase {
 final ProblemsRepo _repo;

  AddProblemUseCase( this._repo);

  Future<ApiResult<AddProblemResponse>> call(AddProblemRequest request) async {
    return await _repo.addProblem(request);
  }
}