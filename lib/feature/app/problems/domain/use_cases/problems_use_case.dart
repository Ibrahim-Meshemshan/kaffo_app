import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';
import 'package:kaffo/feature/app/problems/domain/repositories/problems_repo.dart';

@injectable
class ProblemsUseCase {
 final ProblemsRepo _repo;

  ProblemsUseCase( this._repo);

  Future<Result<List<ProblemsContentEntity>>> call() async {
    return await _repo.fetchProblems();
  }
}
