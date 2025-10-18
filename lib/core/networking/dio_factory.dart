import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:watch_verse/core/di/di.dart';
import 'package:watch_verse/features/auth/data/repos/auth_repo.dart';

class DioFactory {
  static Dio? dio;

  DioFactory._privateConstructor();

  static Dio getDio() {
    if (dio == null) {
      dio = Dio(BaseOptions());

      _addDioInterceptors();
    }

    return dio!;
  }

  static void _addDioInterceptors() {
    // token interceptor
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final authRepo = getIt<AuthRepo>();
          final path = options.path;

          // Skip token for public endpoints
          if (path.contains('/auth/login') || path.contains('/auth/signup')) {
            return handler.next(options);
          }

          // Use refresh token for refresh endpoint
          if (path.contains('/auth/refresh')) {
            final refreshToken = await authRepo.getRefreshToken();
            if (refreshToken != null) {
              options.headers['Authorization'] = 'Bearer $refreshToken';
            }
            return handler.next(options);
          }

          // Normal authenticated requests
          final accessToken = await authRepo.getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }

          handler.next(options);
        },
      ),
    );

    // logger
    dio?.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
      ),
    );
  }
}
