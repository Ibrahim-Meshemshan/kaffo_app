import 'package:json_annotation/json_annotation.dart';

part 'user_response_dto.g.dart';

@JsonSerializable()
class UserResponseDto {
  num? id;
  String? keycloakId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? dateOfBirth;
  String? collegeDegree;
  String? job;
  String? cvUrl;
  String? photoUrl;
  String? description;
  num? addressId;
  num? govId;

  UserResponseDto({
    this.id,
    this.keycloakId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.collegeDegree,
    this.job,
    this.cvUrl,
    this.photoUrl,
    this.description,
    this.addressId,
    this.govId,
  });

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseDtoToJson(this);
}
