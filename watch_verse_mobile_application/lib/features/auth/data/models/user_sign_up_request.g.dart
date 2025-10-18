// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_sign_up_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignUpRequest _$UserSignUpRequestFromJson(Map<String, dynamic> json) =>
    UserSignUpRequest(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserSignUpRequestToJson(UserSignUpRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };
