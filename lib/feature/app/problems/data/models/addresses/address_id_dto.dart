import 'package:json_annotation/json_annotation.dart';

part 'address_id_dto.g.dart';

@JsonSerializable()
class AddressIdDto {
  num? id;
  num? latitude;
  num? longitude;
  String? city;
  String? description;

  AddressIdDto({this.id, this.latitude, this.longitude, this.city, this.description});

  factory AddressIdDto.fromJson(Map<String, dynamic> json) => _$AddressIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressIdDtoToJson(this);
}

