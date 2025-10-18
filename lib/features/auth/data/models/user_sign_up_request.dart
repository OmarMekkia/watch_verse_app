

import 'package:json_annotation/json_annotation.dart';

part 'user_sign_up_request.g.dart';

@JsonSerializable()
class UserSignUpRequest {
  final String username;
  final String email;
  final String password;

  UserSignUpRequest({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$UserSignUpRequestToJson(this);
  factory UserSignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$UserSignUpRequestFromJson(json);
}
