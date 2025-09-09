import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/auth/login/data/model/login_request/login_request.dart';
import 'package:kaffo/feature/auth/login/data/model/login_response/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<Result<LoginResponse>> login({required LoginRequest loginRequest});
}
