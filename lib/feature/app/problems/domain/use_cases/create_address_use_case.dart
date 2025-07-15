import 'package:injectable/injectable.dart';
import 'package:kaffo/feature/app/problems/domain/entities/address/address_request.dart';

import '../../../../../core/models/result.dart';
import '../../data/models/addresses/address_response.dart';
import '../repositories/problems_repo.dart';

@injectable
class CreateAddressUseCase {
  final ProblemsRepo _repo;

  CreateAddressUseCase( this._repo);

  Future<Result<AddressResponse>> call(AddressRequest request) async {
    return await _repo.createAddress(request);
  }
}