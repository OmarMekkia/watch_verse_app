import 'package:json_annotation/json_annotation.dart';
part 'token_pair_response.g.dart';

@JsonSerializable()
class TokenPairResponse {
  final String accessToken;
  final String refreshToken;

  TokenPairResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenPairResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenPairResponseFromJson(json);
}