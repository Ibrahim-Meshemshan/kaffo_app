// import 'package:injectable/injectable.dart';
// import 'package:kaffo/feature/app/problems/domain/entities/add_problem_request_entity.dart';
// import 'package:kaffo/feature/app/problems/domain/entities/add_problem_response_entity.dart';
//
// import '../../../../../core/models/result.dart';
// import '../repositories/problems_repo.dart';
//
// @injectable
// class AddProblemUseCase {
//   ProblemsRepo repo;
//
//   AddProblemUseCase({required this.repo});
//
//   Future<Result<AddProblemResponseEntity>> call(AddProblemRequest request) async {
//     return await repo.addProblem(request);
//   }
// }