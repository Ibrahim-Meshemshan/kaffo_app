import 'package:json_annotation/json_annotation.dart';

part 'edit_user_profile_response.g.dart';

@JsonSerializable()
class EditUserProfileResponse {
  int? id;
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

  EditUserProfileResponse({ this.id,  this.keycloakId,  this.firstName,  this.lastName,  this.email,  this.phone,  this.dateOfBirth,  this.collegeDegree,  this.job,  this.description,  this.addressId});

  factory EditUserProfileResponse.fromJson(Map<String, dynamic> json) => _$EditUserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserProfileResponseToJson(this);
}

