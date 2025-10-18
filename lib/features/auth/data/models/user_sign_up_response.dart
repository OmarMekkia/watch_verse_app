import 'package:json_annotation/json_annotation.dart';
part 'user_sign_up_response.g.dart';

@JsonSerializable()
class UserSignUpResponse {
  final String id;
  final String username;
  final String email;
  final String createdAt;
  final String updatedAt;

  UserSignUpResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserSignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSignUpResponseFromJson(json);
}
