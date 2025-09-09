import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/profile/data/model/get_user_profile_response.dart';
import 'package:kaffo/feature/app/profile/domain/repos/profile_repo.dart';

@injectable
class GetUserPorfileUseCase {
  ProfileRepo _profileRepo;
  GetUserPorfileUseCase(this._profileRepo);

  Future<Result<GetUserProfileResponse>> call() async {
    return await _profileRepo.getUserProfile();
  }

}
