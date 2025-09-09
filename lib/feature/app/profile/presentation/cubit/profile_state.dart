part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final Status profileState;
  final String? profileError;
  final GetUserProfileResponse ?getUserProfileResponse;

  final Status editProfileState;
  final String? editProfileError;
  final EditUserProfileResponse?editUserProfileResponse;

  final Status citiesState;
  final List<CitiesModel>? citiesList;
  final String? citiesError;
  final CitiesModel? selectedCity;

  final Map<int, AddressResponse> addressMap;
  final AddressResponse? addressResponse;
  final Status addressState;
  final String? addressError;



  final Status postState;


  final bool isEdited;
  final bool isEnableToEdit;
  final num ?userId;


  final Status updateUserAddressState;
  final String? updateUserAddressError;
  final UpdateUserAddressResponse?updateUserAddressResponse;


  ProfileState(  {this.postState=Status.initial,this.updateUserAddressState=Status.initial, this.updateUserAddressError, this.updateUserAddressResponse, this.addressResponse,this.isEnableToEdit=false,this.isEdited=false,this.citiesState=Status.initial, this.citiesList, this.citiesError, this.addressMap= const {}, this.addressState=Status.initial, this.addressError,
    this.profileState = Status.initial,
    this.userId,this.selectedCity,
    this.editProfileState = Status.initial,this.getUserProfileResponse,this.editUserProfileResponse,this.profileError,this.editProfileError
  });

  ProfileState copyWith({
    Status?postState,
    Status? profileState,
     String? profileError,
    String? editProfileError,
    Status? editProfileState,
    AddressResponse ?addressResponse,
     Status ?updateUserAddressState,
     String? updateUserAddressError,
     UpdateUserAddressResponse?updateUserAddressResponse,
    bool? isEdited,
    bool? isEnableToEdit,
     GetUserProfileResponse ?getUserProfileResponse,
     EditUserProfileResponse?editUserProfileResponse,
    num ?userId,
     Status ?citiesState,
     List<CitiesModel>? citiesList,
     String? citiesError,
     Map<int, AddressResponse>? addressMap,
     Status? addressState,
     String? addressError,
     CitiesModel? selectedCity,
  }) {
    return ProfileState(
        profileState: profileState ?? this.profileState,
        postState: postState ?? this.postState,
      editProfileState: editProfileState ?? this.editProfileState,
      getUserProfileResponse: getUserProfileResponse??this.getUserProfileResponse,
      editUserProfileResponse: editUserProfileResponse??this.editUserProfileResponse
        ,profileError: profileError??this.profileError,editProfileError: editProfileError??this.editProfileError
        ,      isEdited: isEdited ?? this.isEdited,
      isEnableToEdit: isEnableToEdit ?? this.isEnableToEdit,
      userId: userId??this.userId,
      citiesState:citiesState??this.citiesState,
      citiesError:citiesError??this.citiesError,
      citiesList:citiesList??this.citiesList,      addressMap: addressMap ?? this.addressMap,
      addressState: addressState ?? this.addressState,
      addressError: addressError ?? this.addressError,
      selectedCity: selectedCity??this.selectedCity,
      addressResponse:addressResponse??this.addressResponse,
      updateUserAddressError: updateUserAddressError??this.updateUserAddressError,
      updateUserAddressResponse: updateUserAddressResponse??this.updateUserAddressResponse,
      updateUserAddressState: updateUserAddressState??this.updateUserAddressState
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [        citiesState,selectedCity,updateUserAddressState,updateUserAddressError,updateUserAddressResponse
        ,postState,
        citiesList,
        citiesError,
        profileState,        addressMap,
        addressState,
        addressError,
        editProfileState,
        addressResponse,
        userId,
        getUserProfileResponse,editUserProfileResponse,profileError,editProfileError,        isEdited,
        isEnableToEdit,
      ];

}