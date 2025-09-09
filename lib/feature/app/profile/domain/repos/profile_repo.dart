import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_request.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_response.dart';
import 'package:kaffo/feature/app/profile/data/model/post_response.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_request.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_response.dart';

import '../../data/model/get_user_profile_response.dart';

abstract class ProfileRepo {


  Future<Result<GetUserProfileResponse>> getUserProfile();

  Future<Result<EditUserProfileResponse>> editUserProfile(num userId,EditUserProfileRequest editProfileRequest);
  Future<Result<UpdateUserAddressResponse>> updateUserAddress(num userAddress,UpdateUserAddressRequest updateUserAddressRequest);
  Future<Result<PostResponse>> postUserAddress(UpdateUserAddressRequest updateUserAddressRequest);

}
