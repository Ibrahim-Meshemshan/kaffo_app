import 'package:dio/dio.dart';
import 'package:kaffo/core/app_consts/api_constant.dart';
import 'package:kaffo/feature/app/problems/data/models/cities/cities_model.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/problem_by_id_model.dart';
import 'package:kaffo/feature/app/problems/data/models/user_id/user_response_dto.dart';
import 'package:kaffo/feature/app/problems/domain/entities/address/address_request.dart';
import 'package:retrofit/retrofit.dart';
import '../../feature/app/problems/data/models/addresses/address_response.dart';
import '../../feature/app/problems/data/models/problems/add_problem_response.dart';
import '../../feature/app/problems/data/models/problems/problem_response_dto.dart';
import '../../feature/app/problems/domain/entities/problem/add_problem_request.dart';


part 'api_manager.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET(ApiConstant.problems)
  Future<ProblemResponseDto> fetchProblems();

  @GET('${ApiConstant.userId}/{userId}')
  Future<UserResponseDto> fetchUsers(@Path('userId') int userId);

  @GET('${ApiConstant.addresses}/{addressId}')
  Future<AddressResponse> fetchAddress(@Path('addressId') int addressId);

  @GET('${ApiConstant.problems}/{problemId}')
  Future<ProblemByIdModel> fetchProblemById(@Path('problemId') int problemId);

  @POST(ApiConstant.problems)
  Future<AddProblemResponse> addProblem(@Body() AddProblemRequest body);

  @POST('addresses')
  Future<AddressResponse> createAddress(@Body() AddressRequest body);

  @GET('addresses/cities')
  Future<List<CitiesModel>> fetchCities();

}
