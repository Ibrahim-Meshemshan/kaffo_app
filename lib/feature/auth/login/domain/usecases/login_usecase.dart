
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/auth/login/data/model/login_request/login_request.dart';
import 'package:kaffo/feature/auth/login/data/model/login_response/login_response.dart';
import 'package:kaffo/feature/auth/login/domain/repository_icontract/login_contract.dart';

@injectable
class LoginUsecase {
  final LoginContract login_repo;

  LoginUsecase({required this.login_repo});

  Future<Result<LoginResponse>> invoke({
    required LoginRequest loginRequest,
  }) async {
    return await login_repo.login(loginRequest: loginRequest);
  }
}
