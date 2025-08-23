import 'package:json_annotation/json_annotation.dart';

part 'problems_content_entity.g.dart';

@JsonSerializable()
class ProblemsContentEntity {
  final int? id;
  final String? title;
  final String? description;
  final bool? isReal;
  final bool? forContribution;
  final bool? forDonation;
  final String? submissionDate;
  final String? status;
  final int? addressId;
  final int? submittedByUserId;
  final int? approvedByUserId;
  final int? categoryId;

  ProblemsContentEntity({
    this.id,
    this.title,
    this.description,
    this.isReal,
    this.forContribution,
    this.forDonation,
    this.submissionDate,
    this.status,
    this.addressId,
    this.submittedByUserId,
    this.approvedByUserId,
    this.categoryId,
  });


  factory ProblemsContentEntity.fromJson(Map<String, dynamic> json) =>
      _$ProblemsContentEntityFromJson(json);


  Map<String, dynamic> toJson() => _$ProblemsContentEntityToJson(this);
}
