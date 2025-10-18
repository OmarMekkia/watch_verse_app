part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticating() = Authenticating;
  const factory AuthState.authenticated() = Authenticated;
  const factory AuthState.refreshing() = Refreshing;
  const factory AuthState.error(String message) = Error;

}
