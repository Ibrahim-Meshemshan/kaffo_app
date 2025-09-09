import 'package:dio/dio.dart';
import 'package:kaffo/feature/auth/login/data/model/login_response/login_response.dart';
import 'package:kaffo/core/app_consts/api_constant.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'auth_manager.g.dart';

@RestApi(baseUrl:ApiConstant.auhtBaseUrl)
abstract class AuthClient {
  factory AuthClient(Dio dio, {String? baseUrl}) = _AuthClient;

  @FormUrlEncoded()
  @POST("/realms/kafu-realm/protocol/openid-connect/token")
  Future<LoginResponse> login(
      @Field("username") String username,
      @Field("password") String password, {
        @Field("grant_type") String grantType = "password",
        @Field("client_id") String clientId = "flutter-app",
        @Field("scope") String scope = "openid email",
      });
}
