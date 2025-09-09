// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      access_token: json['access_token'] as String?,
      expires_in: json['expires_in'] as num?,
      refresh_expires_in: json['refresh_expires_in'] as num?,
      refresh_token: json['refresh_token'] as String?,
      token_type: json['token_type'] as String?,
      id_token: json['id_token'] as String?,
      not_before_policy: json['not_before_policy'] as num?,
      session_state: json['session_state'] as String?,
      scope: json['scope'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'expires_in': instance.expires_in,
      'refresh_expires_in': instance.refresh_expires_in,
      'refresh_token': instance.refresh_token,
      'token_type': instance.token_type,
      'id_token': instance.id_token,
      'not_before_policy': instance.not_before_policy,
      'session_state': instance.session_state,
      'scope': instance.scope,
    };
