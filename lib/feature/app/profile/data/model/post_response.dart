import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  num? id;
  num ?latitude;
  num ?longitude;
  String? city;
  String? description;

  PostResponse({this.id, this.latitude, this.longitude, this.city, this.description});

  factory PostResponse.fromJson(Map<String, dynamic> json) => _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}

