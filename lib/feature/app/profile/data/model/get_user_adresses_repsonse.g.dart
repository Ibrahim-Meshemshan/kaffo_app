// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_adresses_repsonse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserAdressesRepsonse _$GetUserAdressesRepsonseFromJson(
  Map<String, dynamic> json,
) => GetUserAdressesRepsonse(
  id: json['id'] as num?,
  latitude: json['latitude'] as num?,
  longitude: json['longitude'] as num?,
  city: json['city'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$GetUserAdressesRepsonseToJson(
  GetUserAdressesRepsonse instance,
) => <String, dynamic>{
  'id': instance.id,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'city': instance.city,
  'description': instance.description,
};
