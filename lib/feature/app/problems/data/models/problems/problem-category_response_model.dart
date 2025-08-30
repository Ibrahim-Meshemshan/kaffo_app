// To parse this JSON data, do
//
//     final problemCategoryResponseModel = problemCategoryResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProblemCategoryResponseModel> problemCategoryResponseModelFromJson(String str) => List<ProblemCategoryResponseModel>.from(json.decode(str).map((x) => ProblemCategoryResponseModel.fromJson(x)));

String problemCategoryResponseModelToJson(List<ProblemCategoryResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProblemCategoryResponseModel {
  int id;
  String name;
  int govId;

  ProblemCategoryResponseModel({
    required this.id,
    required this.name,
    required this.govId,
  });

  factory ProblemCategoryResponseModel.fromJson(Map<String, dynamic> json) => ProblemCategoryResponseModel(
    id: json["id"],
    name: json["name"],
    govId: json["govId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "govId": govId,
  };
}
