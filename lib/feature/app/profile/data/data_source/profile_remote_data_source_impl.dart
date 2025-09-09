import 'package:injectable/injectable.dart';
import 'package:kaffo/core/api_manager/api_execute.dart';
import 'package:kaffo/core/api_manager/api_manager.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/profile/data/data_source/profile_remote_data_source.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_request.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_response.dart';
import 'package:kaffo/feature/app/profile/data/model/get_user_profile_response.dart';
import 'package:kaffo/feature/app/profile/data/model/post_response.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_request.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_response.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final RestClient _restClient;

  ProfileRemoteDataSourceImpl(  this._restClient);

  @override
  Future<Result<EditUserProfileResponse>> editUserProfile(num userId,EditUserProfileRequest editProfileRequest) {
    return ApiExecute.executeApi<EditUserProfileResponse>(() async{
      return await _restClient.editUserProfile(userId,editProfileRequest);
    },);
  }

  @override
  Future<Result<GetUserProfileResponse>> getUserProfile() {
    return ApiExecute.executeApi<GetUserProfileResponse>(() async{
      final response = await _restClient.getUserProfile();
      return response;
    },);
  }

  @override
  Future<Result<UpdateUserAddressResponse>> updateUserAddress(num userAddress, UpdateUserAddressRequest updateUserAddressRequest  ) {
    return ApiExecute.executeApi<UpdateUserAddressResponse>(() async{
      return await _restClient.updateUserAddress(userAddress,updateUserAddressRequest);
    },);
  }

  @override
  Future<Result<PostResponse>> postUserAddress(UpdateUserAddressRequest updateUserAddressRequest) {
    return ApiExecute.executeApi<PostResponse>(() async{
      return await _restClient.postUserAddress(updateUserAddressRequest);
    },);


}}
