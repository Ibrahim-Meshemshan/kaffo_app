// To parse this JSON data, do
//
//     final photoResponseModel = photoResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PhotoResponseModel> photoResponseModelFromJson(String str) => List<PhotoResponseModel>.from(json.decode(str).map((x) => PhotoResponseModel.fromJson(x)));

String photoResponseModelToJson(List<PhotoResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhotoResponseModel {
  int id;
  int problemId;
  String s3Key;
  DateTime photoDate;
  final int? progressId;

  PhotoResponseModel({
    required this.id,
    required this.problemId,
    required this.s3Key,
    required this.photoDate,
     this.progressId,
  });

  factory PhotoResponseModel.fromJson(Map<String, dynamic> json) => PhotoResponseModel(
    id: json["id"],
    problemId: json["problemId"],
    s3Key: json["s3Key"],
    photoDate: DateTime.parse(json["photoDate"]),
    progressId: json["progressId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "problemId": problemId,
    "s3Key": s3Key,
    "photoDate": photoDate.toIso8601String(),
    "progressId": progressId,
  };
}
