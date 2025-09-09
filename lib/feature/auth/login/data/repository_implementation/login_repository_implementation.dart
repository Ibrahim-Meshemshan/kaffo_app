
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:kaffo/feature/auth/login/data/model/login_request/login_request.dart';
import 'package:kaffo/feature/auth/login/data/model/login_response/login_response.dart';
import 'package:kaffo/feature/auth/login/domain/repository_icontract/login_contract.dart';

@Injectable(as: LoginContract)
class LoginRepositoryImplementation implements LoginContract {
  final LoginRemoteDataSource _loginRemoteDataSource;
  LoginRepositoryImplementation({
    required LoginRemoteDataSource loginRemoteDataSource,
  }) : _loginRemoteDataSource = loginRemoteDataSource;

  @override
  Future<Result<LoginResponse>> login({
    required LoginRequest loginRequest,
  }) async {
    return await _loginRemoteDataSource.login(loginRequest: loginRequest);
  }
}
