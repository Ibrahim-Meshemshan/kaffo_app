import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? access_token;
  num ?expires_in;
  num? refresh_expires_in;
  String? refresh_token;
  String? token_type;
  String? id_token;
  num? not_before_policy;
  String? session_state;
  String? scope;

  LoginResponse({this.access_token, this.expires_in, this.refresh_expires_in, this.refresh_token, this.token_type, this.id_token, this.not_before_policy, this.session_state, this.scope});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

