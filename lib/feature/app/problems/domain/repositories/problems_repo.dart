import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/data/models/cities/cities_model.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/add_problem_response.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/problem_by_id_model.dart';

import '../../data/models/addresses/address_response.dart';
import '../../data/models/user_id/user_response_dto.dart';
import '../entities/address/address_request.dart';
import '../entities/problem/add_problem_request.dart';
import '../entities/problem/problems_content_entity.dart';

abstract class ProblemsRepo {
  Future<ApiResult<List<ProblemsContentEntity>>> fetchProblems();

  Future<ApiResult<UserResponseDto>> fetchUsers(int userId);

  Future<ApiResult<AddressResponse>> fetchAddress(int addressId);

  Future<ApiResult<AddProblemResponse>> addProblem(AddProblemRequest request);

  Future<ApiResult<AddressResponse>> createAddress(AddressRequest request);

  Future<ApiResult<List<CitiesModel>>> fetchCities();

  Future<ApiResult<ProblemByIdModel>> fetchProblemById(int problemId);
}
