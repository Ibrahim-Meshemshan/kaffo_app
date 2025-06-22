import 'package:injectable/injectable.dart';
import '../../../../../core/models/result.dart';
import '../../data/models/user_id/user_response_dto.dart';
import '../repositories/problems_repo.dart';

@injectable
class UserUseCase {
  final ProblemsRepo _repo;

  UserUseCase( this._repo);

  Future<Result<UserResponseDto>> call(int userId) async {
    return await _repo.fetchUsers(userId);
  }
}
