import 'package:injectable/injectable.dart';
import 'package:kaffo/feature/app/problems/data/models/cities/cities_model.dart';

import '../../../../../core/models/result.dart';
import '../repositories/problems_repo.dart';

@injectable
class CitiesUseCase {
  final ProblemsRepo _repo;

  CitiesUseCase( this._repo);

  Future<ApiResult<List<CitiesModel>>> call() async {
    return await _repo.fetchCities();
  }
}
