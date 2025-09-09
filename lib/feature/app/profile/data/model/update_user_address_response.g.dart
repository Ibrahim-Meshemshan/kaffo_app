// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserAddressResponse _$UpdateUserAddressResponseFromJson(
  Map<String, dynamic> json,
) => UpdateUserAddressResponse(
  id: json['id'] as num?,
  latitude: json['latitude'] as num?,
  longitude: json['longitude'] as num?,
  city: json['city'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$UpdateUserAddressResponseToJson(
  UpdateUserAddressResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'city': instance.city,
  'description': instance.description,
};
