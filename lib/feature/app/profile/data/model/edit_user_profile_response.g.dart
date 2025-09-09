// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditUserProfileResponse _$EditUserProfileResponseFromJson(
  Map<String, dynamic> json,
) => EditUserProfileResponse(
  id: (json['id'] as num?)?.toInt(),
  keycloakId: json['keycloakId'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  collegeDegree: json['collegeDegree'] as String?,
  job: json['job'] as String?,
  description: json['description'] as String?,
  addressId: json['addressId'] as num?,
);

Map<String, dynamic> _$EditUserProfileResponseToJson(
  EditUserProfileResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'keycloakId': instance.keycloakId,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'phone': instance.phone,
  'dateOfBirth': instance.dateOfBirth,
  'collegeDegree': instance.collegeDegree,
  'job': instance.job,
  'description': instance.description,
  'addressId': instance.addressId,
};
