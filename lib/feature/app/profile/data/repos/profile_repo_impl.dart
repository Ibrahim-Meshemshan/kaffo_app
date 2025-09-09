
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/error_handler/exception_impl.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/profile/data/data_source/profile_remote_data_source.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_request.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_response.dart';
import 'package:kaffo/feature/app/profile/data/model/get_user_profile_response.dart';
import 'package:kaffo/feature/app/profile/data/model/post_response.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_request.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_response.dart';
import 'package:kaffo/feature/app/profile/domain/repos/profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo {
  ProfileRemoteDataSource _profileRemoteDataSource;
  ProfileRepoImpl(this._profileRemoteDataSource);

  @override
  Future<Result<EditUserProfileResponse>> editUserProfile(num userId, EditUserProfileRequest editProfileRequest) async {
    try {
      return await _profileRemoteDataSource.editUserProfile(userId,editProfileRequest);
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }

  @override
  Future<Result<GetUserProfileResponse>> getUserProfile()async {
    try {
      return await _profileRemoteDataSource.getUserProfile();
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }

  @override
  Future<Result<UpdateUserAddressResponse>> updateUserAddress(num userAddress, UpdateUserAddressRequest updateUserAddressRequest) async{
    try {
      return await _profileRemoteDataSource.updateUserAddress(userAddress, updateUserAddressRequest);
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }

  @override
  Future<Result<PostResponse>> postUserAddress(UpdateUserAddressRequest updateUserAddressRequest)async {
    try {
      return await _profileRemoteDataSource.postUserAddress( updateUserAddressRequest);
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }



}
