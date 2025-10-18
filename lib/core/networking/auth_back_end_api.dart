import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:watch_verse/features/auth/data/models/refresh_token_request.dart';
import 'package:watch_verse/features/auth/data/models/token_pair_response.dart';
import 'package:watch_verse/features/auth/data/models/user_login_request.dart';
import 'package:watch_verse/features/auth/data/models/user_sign_up_response.dart';
import 'package:watch_verse/features/auth/data/models/user_sign_up_request.dart';

part 'auth_back_end_api.g.dart';

@RestApi(baseUrl: "http://localhost:8080")
abstract class AuthBackendApi {
  factory AuthBackendApi(Dio dio, {String baseUrl}) = _AuthBackendApi;

  @POST("/auth/signup")
  Future<UserSignUpResponse> signUp(
    @Body() UserSignUpRequest request,
  );

  @POST("/auth/login")
  Future<TokenPairResponse> login(
    @Body() UserLoginRequest request,
  );
  @POST("/auth/refresh")
  Future<TokenPairResponse> refresh(
    @Body() RefreshTokenRequest request,
  );
}
