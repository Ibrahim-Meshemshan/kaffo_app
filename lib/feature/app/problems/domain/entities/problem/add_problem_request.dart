import 'package:json_annotation/json_annotation.dart';

part 'add_problem_request.g.dart';

@JsonSerializable()
class AddProblemRequest {
  final String title;
  final String description;
  final int categoryId;
  final num? addressId;



  final List<String> photoUrls;

  AddProblemRequest({
    required this.title,
    required this.description,
    required this.categoryId,
    this.addressId,



    required this.photoUrls,
  });

  factory AddProblemRequest.fromJson(Map<String, dynamic> json) =>
      _$AddProblemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddProblemRequestToJson(this);
}