import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_request.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_response.dart';
import 'package:kaffo/feature/app/profile/domain/repos/profile_repo.dart';


@injectable
class EditUserProfileUseCase {
  ProfileRepo _profileRepo;
  EditUserProfileUseCase(this._profileRepo);

  Future<Result<EditUserProfileResponse>> call(num userId,EditUserProfileRequest editProfileRequest) async {
    return await _profileRepo.editUserProfile(userId,editProfileRequest);
  }


}