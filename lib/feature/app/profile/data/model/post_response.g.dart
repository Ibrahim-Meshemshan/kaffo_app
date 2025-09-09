// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse(
  id: json['id'] as num?,
  latitude: json['latitude'] as num?,
  longitude: json['longitude'] as num?,
  city: json['city'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
      'description': instance.description,
    };
