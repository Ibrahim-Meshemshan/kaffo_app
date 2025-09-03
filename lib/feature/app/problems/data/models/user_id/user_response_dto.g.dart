// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseDto _$UserResponseDtoFromJson(Map<String, dynamic> json) =>
    UserResponseDto(
      id: json['id'] as num?,
      keycloakId: json['keycloakId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      collegeDegree: json['collegeDegree'] as String?,
      job: json['job'] as String?,
      cvUrl: json['cvUrl'] as String?,
      photoUrl: json['photoUrl'] as String?,
      description: json['description'] as String?,
      addressId: json['addressId'] as num?,
      govId: json['govId'] as num?,
    );

Map<String, dynamic> _$UserResponseDtoToJson(UserResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'keycloakId': instance.keycloakId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'dateOfBirth': instance.dateOfBirth,
      'collegeDegree': instance.collegeDegree,
      'job': instance.job,
      'cvUrl': instance.cvUrl,
      'photoUrl': instance.photoUrl,
      'description': instance.description,
      'addressId': instance.addressId,
      'govId': instance.govId,
    };
