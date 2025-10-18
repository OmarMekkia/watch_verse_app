import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:watch_verse/core/networking/api_result.dart';
import 'package:watch_verse/features/auth/data/models/refresh_token_request.dart';
import 'package:watch_verse/features/auth/data/models/user_login_request.dart';
import 'package:watch_verse/features/auth/data/models/user_sign_up_request.dart';
import 'package:watch_verse/features/auth/data/repos/auth_repo.dart';
part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit({required this.authRepo}) : super(AuthState.unauthenticated());

  void unauthenticated() {
    emit(AuthState.unauthenticated());
  }

  void signUp(UserSignUpRequest request) async {
    print("🔄 Starting signup process for email: ${request.email}");
    emit(AuthState.authenticating());

    final result = await authRepo.signUp(request);
    result.when(
      success: (data) {
        print("✅ Signup successful for user: ${data.username}");
        emit(AuthState.authenticated());
      },
      error: (message) {
        print("❌ Signup failed with error: $message");
        emit(AuthState.error(message));
      },
    );
  }

  void logIn(UserLoginRequest request) {
    print("🔄 Starting login process for email: ${request.email}");
    emit(AuthState.authenticating());
    authRepo.login(request).then((result) {
      result.when(
        success: (data) {
          print("✅ Login successful");
          emit(AuthState.authenticated());
        },
        error: (message) {
          print("❌ Login failed with error: $message");
          emit(AuthState.error(message));
        },
      );
    });
  }

  void logOut() {
    emit(AuthState.unauthenticated());
  }

  void refresh(RefreshTokenRequest request) {
    emit(AuthState.refreshing());
    final data = authRepo.refresh(request);
    data.then((result) {
      result.when(
        success: (data) {
          emit(AuthState.authenticated());
        },
        error: (message) {
          emit(AuthState.unauthenticated());
          emit(AuthState.error(message));
        },
      );
    });
  }
}
