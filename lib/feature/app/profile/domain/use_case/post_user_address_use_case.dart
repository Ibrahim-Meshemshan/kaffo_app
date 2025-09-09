import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_request.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_response.dart';
import 'package:kaffo/feature/app/profile/data/model/post_response.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_request.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_response.dart';
import 'package:kaffo/feature/app/profile/domain/repos/profile_repo.dart';


@injectable
class PostUserAddressUseCase {
  ProfileRepo _profileRepo;
  PostUserAddressUseCase(this._profileRepo);

  Future<Result<PostResponse>> call(UpdateUserAddressRequest updateUserAddressRequest) async {
    return await _profileRepo.postUserAddress(updateUserAddressRequest);
  }


}