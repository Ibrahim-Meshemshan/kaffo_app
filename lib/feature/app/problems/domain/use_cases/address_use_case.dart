import 'package:injectable/injectable.dart';
import '../../../../../core/models/result.dart';
import '../../data/models/addresses/address_response.dart';
import '../repositories/problems_repo.dart';

@injectable
class AddressUseCase {
  final ProblemsRepo _repo;

  AddressUseCase(this._repo);

  Future<ApiResult<AddressResponse>> call(int addressId) async {
    return await _repo.fetchAddress(addressId);
  }
}
