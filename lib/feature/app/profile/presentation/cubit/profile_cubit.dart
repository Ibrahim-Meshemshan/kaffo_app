import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/core/utils/status.dart';
import 'package:kaffo/feature/app/problems/data/models/addresses/address_response.dart';
import 'package:kaffo/feature/app/problems/data/models/cities/cities_model.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/address_use_case.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/cities_use_case.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_request.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_response.dart';
import 'package:kaffo/feature/app/profile/data/model/get_user_adresses_repsonse.dart';
import 'package:kaffo/feature/app/profile/data/model/get_user_profile_response.dart';
import 'package:kaffo/feature/app/profile/data/model/post_response.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_request.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_response.dart';
import 'package:kaffo/feature/app/profile/domain/use_case/edit_user_profile_use_case.dart';
import 'package:kaffo/feature/app/profile/domain/use_case/get_user_porfile_use_case.dart';
import 'package:kaffo/feature/app/profile/domain/use_case/post_user_address_use_case.dart';
import 'package:kaffo/feature/app/profile/domain/use_case/update_user_address_use_case.dart';

part 'profile_state.dart';
@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetUserPorfileUseCase getUserPorfileUseCase;
  final EditUserProfileUseCase editUserProfileUseCase;
  final UpdateUserAddressUseCase updateUserAddressUseCase;
  final PostUserAddressUseCase postUserAddressUseCase;
  final AddressUseCase addressUseCase;
  final CitiesUseCase citiesUseCase;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController collegeDegreeController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  String ?addressIdController;
  TextEditingController descriptionController = TextEditingController();
num?addressId;
  TextEditingController cityController = TextEditingController();

  ProfileCubit(this.getUserPorfileUseCase, this.editUserProfileUseCase,this.addressUseCase,this.citiesUseCase,this.updateUserAddressUseCase,this.postUserAddressUseCase)
      : super(ProfileState());
  void toggleMainEdit() {
    emit(state.copyWith(
      isEdited: !state.isEdited,
    ));
  }
  void toggleEdit() {
    emit(state.copyWith(
      isEnableToEdit: !state.isEnableToEdit,
    ));
  }
  Future<void> getUserProfile() async {
    emit(state.copyWith(profileState: Status.loading));
    Result<GetUserProfileResponse> result = await getUserPorfileUseCase.call();
    switch (result) {
      case Success<GetUserProfileResponse>():
        print("dddd");
        print(result.data?.email);
        print(result.data);
       await fetchCities();
await        fetchAddress(result.data?.addressId?.toInt()??5);
        firstNameController.text=result.data?.firstName ??"";
        lastNameController.text=result.data?.lastName ??"";
        emailController.text=result.data?.email ??"";
        phoneController.text=result.data?.phone ??"";
        dateOfBirthController.text=result.data?.dateOfBirth ??"";
        collegeDegreeController.text=result.data?.collegeDegree ??"";
        jobController.text=result.data?.job ??"";
       addressId=result.data?.addressId;
        emit(
          state.copyWith(
            profileState: Status.success,
            getUserProfileResponse: result.data,
            userId: result.data?.id,
          ),
        );
      case Error<GetUserProfileResponse>():
        emit(
          state.copyWith(
            profileState: Status.error,
            profileError: result.exception.toString(),
          ),
        );
    }
  }


  Future<void> fetchCities() async {
    emit(state.copyWith(citiesState: Status.loading));
    Result<List<CitiesModel>> result = await citiesUseCase.call();
    switch (result) {
      case Success<List<CitiesModel>>():
        emit(state.copyWith(
            citiesState: Status.success, citiesList: result.data));
      case Error<List<CitiesModel>>():
        emit(state.copyWith(citiesState: Status.error,
            citiesError: result.exception.toString()));
    }
  }
  Future<void> fetchAddress(int addressId) async {
    emit(state.copyWith(addressState: Status.loading));
    Result<AddressResponse> result = await addressUseCase.call(addressId);
    switch (result) {
      case Success<AddressResponse>():
      addressIdController=result.data?.city;
      cityController.text=result.data?.description??"";
        emit(
          state.copyWith(
            addressState: Status.success,
            addressResponse: result.data,
          ),
        );
      case Error<AddressResponse>():
        emit(
          state.copyWith(
            addressState: Status.error,
            addressError: result.exception.toString(),
          ),
        );
    }
  }
  String? getArabicCityName(String selectedCity, List<CitiesModel>? cities) {
    if (cities == null) return null;

    try {
      final city = cities.firstWhere(
            (c) => c.english == selectedCity,
        orElse: () => CitiesModel(arabic: '', english: '', value: ''),
      );
      return city.arabic!.isNotEmpty ? city.arabic : null;
    } catch (e) {
      return null;
    }
  }
  Future<void> updateUserAddress(num userAddress,
      UpdateUserAddressRequest updateUserAddressRequest) async
  {
    emit(state.copyWith(updateUserAddressState: Status.loading));
    Result<UpdateUserAddressResponse> result = await updateUserAddressUseCase.call(
        userAddress, updateUserAddressRequest);
    switch (result) {
      case Success<UpdateUserAddressResponse>():
        addressId=result.data?.id;
        emit(state.copyWith(
          updateUserAddressState: Status.success,
          updateUserAddressResponse: result.data,
       ));
        break;

      case Error<UpdateUserAddressResponse>():
        emit(state.copyWith(
          updateUserAddressState: Status.error,
          updateUserAddressError: result.exception.toString(),
        ));
        break;
    }
  }
  Future<void> postUserAddress(
      UpdateUserAddressRequest updateUserAddressRequest) async
  {
    emit(state.copyWith(updateUserAddressState: Status.loading));
    Result<PostResponse> result = await postUserAddressUseCase.call(
        updateUserAddressRequest);
    print(result);
    print("rrrrr");
    switch (result) {
      case Success<PostResponse>():
        print(result.data?.id);
  print(result.data);
        addressId=result.data?.id;
        emit(state.copyWith(
          postState: Status.success,
        ));
        break;

      case Error<PostResponse>():
        emit(state.copyWith(
          postState: Status.error,
        ));
        break;
    }
  }
  Future<void> editUserProfile(num userId,
      EditUserProfileRequest editProfileRequest) async
  {
    print("Aaaa");
    print(userId);
    emit(state.copyWith(editProfileState: Status.loading));
    Result<EditUserProfileResponse> result = await editUserProfileUseCase.call(
        userId, editProfileRequest);
    switch (result) {
      case Success<EditUserProfileResponse>():
        emit(state.copyWith(
          editProfileState: Status.success,
          editUserProfileResponse: result.data,
          isEdited: false,
          userId: result.data?.id,
          isEnableToEdit: false,
        ));
        break;

      case Error<EditUserProfileResponse>():
        emit(state.copyWith(
          editProfileState: Status.error,
          editProfileError: result.exception.toString(),
        ));
        break;
    }
  }
  Future<void>updateUser(num userId,
      EditUserProfileRequest editProfileRequest,num userAddress,
      UpdateUserAddressRequest updateUserAddressRequest)async{
    if(addressId==null){
      print("gg");
      await postUserAddress(updateUserAddressRequest);
    }
   await updateUserAddress(userAddress, updateUserAddressRequest);
   await editUserProfile(userId, editProfileRequest);
  }
  // Future<void> fetchAddress(int addressId) async {
  //   if (state.addressMap[addressId] == null) {
  //     Result<GetUserAdressesRepsonse> result = await addressUseCase(addressId);
  //     switch (result) {
  //       case Success<GetUserAdressesRepsonse>():
  //         emit(state.copyWith(
  //           addressMap: {...state.addressMap, addressId: result.data!},
  //           addressState: Status.success,
  //         ));
  //       case Error<GetUserAdressesRepsonse>():
  //         print("Address fetch error for ID $addressId: ${result.exception}");
  //         emit(state.copyWith(
  //           addressState: Status.error,
  //           addressError: result.exception.toString(),
  //         ));
  //     }
  //   }
  // }

}
