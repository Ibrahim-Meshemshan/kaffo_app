import 'package:json_annotation/json_annotation.dart';

part 'update_user_address_response.g.dart';

@JsonSerializable()
class UpdateUserAddressResponse {
  num ?id;
  num ?latitude;
  num ?longitude;
  String? city;
  String? description;

  UpdateUserAddressResponse({this.id, this.latitude, this.longitude, this.city, this.description});

  factory UpdateUserAddressResponse.fromJson(Map<String, dynamic> json) => _$UpdateUserAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserAddressResponseToJson(this);
}

