import 'package:json_annotation/json_annotation.dart';

part 'edit_user_profile_request.g.dart';

@JsonSerializable()
class EditUserProfileRequest {
  final String ?keycloakId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String ?dateOfBirth; // ISO 8601 format: yyyy-MM-dd
  final String ?collegeDegree;
  final String ?job;
  final String ?cvUrl;
  final String ?photoUrl;
  final String ?description;
  final num? addressId;
  final num ?govId;

  EditUserProfileRequest({
     this.keycloakId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
     this.dateOfBirth,
     this.collegeDegree,
     this.job,
     this.cvUrl,
     this.photoUrl,
     this.description,
     this.addressId,
     this.govId,
  });

  factory EditUserProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$EditUserProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserProfileRequestToJson(this);
}
