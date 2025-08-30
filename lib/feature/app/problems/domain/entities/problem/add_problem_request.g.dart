// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_problem_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProblemRequest _$AddProblemRequestFromJson(Map<String, dynamic> json) =>
    AddProblemRequest(
      title: json['title'] as String,
      description: json['description'] as String,
      categoryId: (json['categoryId'] as num).toInt(),
      addressId: json['addressId'] as num?,
    );

Map<String, dynamic> _$AddProblemRequestToJson(AddProblemRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'addressId': instance.addressId,
    };
