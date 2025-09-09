import 'package:json_annotation/json_annotation.dart';

part 'update_user_address_request.g.dart';

@JsonSerializable()
class UpdateUserAddressRequest {
  final num latitude;
  final num longitude;
  final String city;
  final String ?description;


  UpdateUserAddressRequest({
    required this.latitude,
    required this.longitude,
    required this.city,
     this.description,
  });

  factory UpdateUserAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserAddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserAddressRequestToJson(this);
}
