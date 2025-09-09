import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_request.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_response.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_request.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_response.dart';
import 'package:kaffo/feature/app/profile/domain/repos/profile_repo.dart';


@injectable
class UpdateUserAddressUseCase {
  ProfileRepo _profileRepo;
  UpdateUserAddressUseCase(this._profileRepo);

  Future<Result<UpdateUserAddressResponse>> call(num userId,UpdateUserAddressRequest updateUserAddressRequest) async {
    return await _profileRepo.updateUserAddress(userId,updateUserAddressRequest);
  }


}