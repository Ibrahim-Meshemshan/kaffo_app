import 'package:json_annotation/json_annotation.dart';

part 'cities_model.g.dart';

@JsonSerializable()
class CitiesModel {
  final String? arabic;
  final String? english;
  final String? value;

  CitiesModel({
    this.arabic,
    this.english,
    this.value,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) =>
      _$CitiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CitiesModelToJson(this);
}
