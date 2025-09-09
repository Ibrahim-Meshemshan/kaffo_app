import 'package:json_annotation/json_annotation.dart';

part 'add_problem_response.g.dart';

@JsonSerializable()
class AddProblemResponse {
  num? id;
  String? title;
  String? description;
  bool isReal = true;
  bool? forContribution;
  bool? forDonation;
  String? submissionDate;
  String? status;
  String? rejectionReason;
  num? addressId;
  num? submittedByUserId;
  num? categoryId;

  AddProblemResponse({this.id, this.title, this.description, required this.isReal, this.forContribution, this.forDonation, this.submissionDate, this.status, this.rejectionReason, this.addressId, this.submittedByUserId, this.categoryId});

  factory AddProblemResponse.fromJson(Map<String, dynamic> json) => _$AddProblemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddProblemResponseToJson(this);
}

