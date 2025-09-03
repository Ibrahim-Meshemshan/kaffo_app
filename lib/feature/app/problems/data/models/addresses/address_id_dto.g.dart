// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressIdDto _$AddressIdDtoFromJson(Map<String, dynamic> json) => AddressIdDto(
  id: json['id'] as num?,
  latitude: json['latitude'] as num?,
  longitude: json['longitude'] as num?,
  city: json['city'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$AddressIdDtoToJson(AddressIdDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
      'description': instance.description,
    };
