import 'package:json_annotation/json_annotation.dart';

part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {
  num? id;
  num? latitude;
  num? longitude;
  String? city;
  String? description;

  AddressResponse({this.id, this.latitude, this.longitude, this.city, this.description});

  factory AddressResponse.fromJson(Map<String, dynamic> json) => _$AddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
}

