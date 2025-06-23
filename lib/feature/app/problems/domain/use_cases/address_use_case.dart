import 'package:injectable/injectable.dart';
import '../../../../../core/models/result.dart';
import '../../data/models/addresses/address_id_dto.dart';
import '../repositories/problems_repo.dart';

@injectable
class AddressUseCase {
  final ProblemsRepo _repo;

  AddressUseCase(this._repo);

  Future<Result<AddressIdDto>> call(int addressId) async {
    return await _repo.fetchAddress(addressId);
  }
}
