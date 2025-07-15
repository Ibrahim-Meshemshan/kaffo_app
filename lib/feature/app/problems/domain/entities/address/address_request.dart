import 'package:json_annotation/json_annotation.dart';

part 'address_request.g.dart';

@JsonSerializable()
class AddressRequest {
  num? latitude;
  num? longitude;
  String? city;
  String? description;

  AddressRequest({
    this.latitude,
    this.longitude,
    this.city,
    this.description,
  });

  factory AddressRequest.fromJson(Map<String, dynamic> json) =>
      _$AddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddressRequestToJson(this);
}
