import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:watch_verse/core/networking/auth_back_end_api.dart';
import 'package:watch_verse/core/networking/api_result.dart';
import 'package:watch_verse/features/auth/data/models/refresh_token_request.dart';
import 'package:watch_verse/features/auth/data/models/token_pair_response.dart';
import 'package:watch_verse/features/auth/data/models/user_login_request.dart';
import 'package:watch_verse/features/auth/data/models/user_sign_up_response.dart';
import 'package:watch_verse/features/auth/data/models/user_sign_up_request.dart';

class AuthRepo {
  AuthBackendApi authApiService;
  final FlutterSecureStorage storage;
  AuthRepo({required this.authApiService, required this.storage});

  Future<void> saveTokens(String access, String refresh) async {
    await storage.write(key: 'access', value: access);
    await storage.write(key: 'refresh', value: refresh);
  }

  Future<String?> getAccessToken() async => storage.read(key: 'access');
  Future<String?> getRefreshToken() async => storage.read(key: 'refresh');

  Future<void> clearTokens() async {
    await storage.delete(key: 'access');
    await storage.delete(key: 'refresh');
  }

  Future<ApiResult<UserSignUpResponse>> signUp(
    UserSignUpRequest request,
  ) async {
    try {
      final data = await authApiService.signUp(request);
      return ApiResult.success(data);
    } catch (e) {


      if (e is DioException) {
        final dioError = e;
 

        switch (dioError.type) {
          case DioExceptionType.connectionTimeout:
            return ApiResult.error(
              "Connection timeout. Please check your internet connection.",
            );
          case DioExceptionType.sendTimeout:
            return ApiResult.error("Request timeout. Please try again.");
          case DioExceptionType.receiveTimeout:
            return ApiResult.error(
              "Server response timeout. Please try again.",
            );
          case DioExceptionType.badResponse:
            final statusCode = dioError.response?.statusCode;
            final message =
                dioError.response?.data?['message'] ?? 'Unknown server error';
            return ApiResult.error("Server error ($statusCode): $message");
          case DioExceptionType.connectionError:
            return ApiResult.error(
              "Connection error. Please check your internet connection and server status.",
            );
          default:
            return ApiResult.error("Network error: ${dioError.message}");
        }
      }

      return ApiResult.error("Unexpected error: ${e.toString()}");
    }
  }

  Future<ApiResult<TokenPairResponse>> login(UserLoginRequest request) async {
    try {
      final data = await authApiService.login(request);
      await saveTokens(data.accessToken, data.refreshToken);
      return ApiResult.success(data);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<TokenPairResponse>> refresh(
    RefreshTokenRequest request,
  ) async {
    try {
      final data = await authApiService.refresh(request);
      return ApiResult.success(data);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }
}
