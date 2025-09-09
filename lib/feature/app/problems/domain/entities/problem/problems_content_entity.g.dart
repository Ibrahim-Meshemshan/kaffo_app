// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problems_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProblemsContentEntity _$ProblemsContentEntityFromJson(
  Map<String, dynamic> json,
) => ProblemsContentEntity(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  isReal: json['isReal'] as bool?,
  forContribution: json['forContribution'] as bool?,
  forDonation: json['forDonation'] as bool?,
  submissionDate: json['submissionDate'] as String?,
  status: json['status'] as String?,
  addressId: (json['addressId'] as num?)?.toInt(),
  submittedByUserId: (json['submittedByUserId'] as num?)?.toInt(),
  approvedByUserId: (json['approvedByUserId'] as num?)?.toInt(),
  categoryId: (json['categoryId'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProblemsContentEntityToJson(
  ProblemsContentEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'isReal': instance.isReal,
  'forContribution': instance.forContribution,
  'forDonation': instance.forDonation,
  'submissionDate': instance.submissionDate,
  'status': instance.status,
  'addressId': instance.addressId,
  'submittedByUserId': instance.submittedByUserId,
  'approvedByUserId': instance.approvedByUserId,
  'categoryId': instance.categoryId,
};
