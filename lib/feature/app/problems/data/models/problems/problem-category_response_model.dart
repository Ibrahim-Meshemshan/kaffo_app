// To parse this JSON data, do
//
//     final problemCategoryResponseModel = problemCategoryResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CategoryResponseModel> problemCategoryResponseModelFromJson(String str) => List<CategoryResponseModel>.from(json.decode(str).map((x) => CategoryResponseModel.fromJson(x)));

String problemCategoryResponseModelToJson(List<CategoryResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryResponseModel {
  int id;
  String name;
  int govId;

  CategoryResponseModel({
    required this.id,
    required this.name,
    required this.govId,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => CategoryResponseModel(
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
