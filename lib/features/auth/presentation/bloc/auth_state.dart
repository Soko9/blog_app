part of "auth_bloc.dart";

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSuccess extends AuthState {
  final Profile profile;
  const AuthSuccess({required this.profile});
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure({required this.message});
}
