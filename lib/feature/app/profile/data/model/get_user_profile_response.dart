import 'package:json_annotation/json_annotation.dart';

part 'get_user_profile_response.g.dart';

@JsonSerializable()
class GetUserProfileResponse {
  num? id;
  String? keycloakId;
  String ?firstName;
  String ?lastName;
  String ?email;
  String ?phone;
  String ?dateOfBirth;
  String ?collegeDegree;
  String ?job;
  String ?description;
  num ?addressId;

  GetUserProfileResponse({this.id, this.keycloakId, this.firstName, this.lastName, this.email, this.phone, this.dateOfBirth, this.collegeDegree, this.job, this.description, this.addressId});

  factory GetUserProfileResponse.fromJson(Map<String, dynamic> json) => _$GetUserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserProfileResponseToJson(this);
}

