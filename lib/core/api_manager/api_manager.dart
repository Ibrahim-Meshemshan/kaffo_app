import 'package:dio/dio.dart';
import 'package:kaffo/core/app_consts/api_constant.dart';
import 'package:kaffo/feature/app/problems/data/models/user_id/user_response_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../../feature/app/problems/data/models/addresses/address_id_dto.dart';
import '../../feature/app/problems/data/models/problems/problem_response_dto.dart';


part 'api_manager.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET(ApiConstant.problems)
  Future<ProblemResponseDto> fetchProblems();

  @GET('${ApiConstant.userId}/{userId}')
  Future<UserResponseDto> fetchUsers(@Path('userId') int userId);

  @GET('${ApiConstant.addresses}/{addressId}')
  Future<AddressIdDto> fetchAddress(@Path('addressId') int addressId);

  // @POST(ApiConstant.problems)
  // Future<AddProblemResponseDto> addProblem(@Body() Map<String, dynamic> body);



}
