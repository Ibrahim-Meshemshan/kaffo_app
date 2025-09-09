// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_problem_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProblemResponse _$AddProblemResponseFromJson(Map<String, dynamic> json) =>
    AddProblemResponse(
      id: json['id'] as num?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      isReal: json['isReal'] as bool?,
      forContribution: json['forContribution'] as bool?,
      forDonation: json['forDonation'] as bool?,
      submissionDate: json['submissionDate'] as String?,
      status: json['status'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      addressId: json['addressId'] as num?,
      submittedByUserId: json['submittedByUserId'] as num?,
      categoryId: json['categoryId'] as num?,
    );

Map<String, dynamic> _$AddProblemResponseToJson(AddProblemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isReal': instance.isReal,
      'forContribution': instance.forContribution,
      'forDonation': instance.forDonation,
      'submissionDate': instance.submissionDate,
      'status': instance.status,
      'rejectionReason': instance.rejectionReason,
      'addressId': instance.addressId,
      'submittedByUserId': instance.submittedByUserId,
      'categoryId': instance.categoryId,
    };
