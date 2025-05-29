import 'package:dio/dio.dart';
import 'package:kaffo/core/app_consts/api_constant.dart';
import 'package:kaffo/feature/app/problems/data/models/add_problem_response_dto.dart';
import 'package:kaffo/feature/app/problems/data/models/problems_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'api_manager.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET(ApiConstant.problems)
  Future<List<ProblemContentDto>> fetchProblems();

  @POST(ApiConstant.problems)
  Future<AddProblemResponseDto> addProblem(@Body() Map<String, dynamic> body);
}
