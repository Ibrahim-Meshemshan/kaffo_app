import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';
import 'package:kaffo/feature/app/problems/domain/repositories/problems_repo.dart';

@injectable
class ProblemsUseCase {
  ProblemsRepo repo;

  ProblemsUseCase({required this.repo});

  Future<Result<List<ProblemsContentEntity>>> call() async {
    return await repo.fetchProblems();
  }
}
