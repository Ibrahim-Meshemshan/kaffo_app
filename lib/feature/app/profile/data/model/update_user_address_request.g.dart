// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_address_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserAddressRequest _$UpdateUserAddressRequestFromJson(
  Map<String, dynamic> json,
) => UpdateUserAddressRequest(
  latitude: json['latitude'] as num,
  longitude: json['longitude'] as num,
  city: json['city'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$UpdateUserAddressRequestToJson(
  UpdateUserAddressRequest instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'city': instance.city,
  'description': instance.description,
};
