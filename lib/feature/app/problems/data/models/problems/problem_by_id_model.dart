import 'package:json_annotation/json_annotation.dart';

part 'problem_by_id_model.g.dart';

@JsonSerializable()
class ProblemByIdModel {
  num? id;
  String? title;
  String? description;
  bool? isReal;
  bool? forContribution;
  bool? forDonation;
  String? submissionDate;
  String? status;
  String? rejectionReason;
  num? addressId;
  num? submittedByUserId;
  num? categoryId;

  ProblemByIdModel({this.id, this.title, this.description, this.isReal, this.forContribution, this.forDonation, this.submissionDate, this.status, this.rejectionReason, this.addressId, this.submittedByUserId, this.categoryId});

  factory ProblemByIdModel.fromJson(Map<String, dynamic> json) => _$ProblemByIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemByIdModelToJson(this);
}

