
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/api_manager/api_execute.dart';
import 'package:kaffo/core/api_manager/auth_manager.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:kaffo/feature/auth/login/data/model/login_request/login_request.dart';
import 'package:kaffo/feature/auth/login/data/model/login_response/login_response.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImp implements LoginRemoteDataSource {
  final AuthClient restClient;
  LoginRemoteDataSourceImp({required this.restClient});

  @override
  Future<Result<LoginResponse>> login({
    required LoginRequest loginRequest,
  }) async {

    return ApiExecute.executeApi<LoginResponse>(() async {
      final response = await restClient.login(loginRequest.email!,loginRequest.password!);

      return response;
    });
  }
}
