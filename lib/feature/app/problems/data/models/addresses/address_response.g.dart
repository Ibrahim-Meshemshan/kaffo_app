// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressResponse _$AddressResponseFromJson(Map<String, dynamic> json) =>
    AddressResponse(
      id: json['id'] as num?,
      latitude: json['latitude'] as num?,
      longitude: json['longitude'] as num?,
      city: json['city'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AddressResponseToJson(AddressResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
      'description': instance.description,
    };
