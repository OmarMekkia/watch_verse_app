// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_sign_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignUpResponse _$UserSignUpResponseFromJson(Map<String, dynamic> json) =>
    UserSignUpResponse(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$UserSignUpResponseToJson(UserSignUpResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
