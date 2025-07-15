import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/data/models/cities/cities_model.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/add_problem_response.dart';

import '../../data/models/addresses/address_response.dart';
import '../../data/models/user_id/user_response_dto.dart';
import '../entities/address/address_request.dart';
import '../entities/problem/add_problem_request.dart';
import '../entities/problem/problems_response_entity.dart';

abstract class ProblemsRepo {
  Future<Result<List<ProblemsContentEntity>>> fetchProblems();

  Future<Result<UserResponseDto>> fetchUsers(int userId);

  Future<Result<AddressResponse>> fetchAddress(int addressId);

  Future<Result<AddProblemResponse>> addProblem(AddProblemRequest request);

  Future<Result<AddressResponse>> createAddress(AddressRequest request);

  Future<Result<List<CitiesModel>>> fetchCities();
}
