part of "auth_bloc.dart";

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthSignUpUserEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const AuthSignUpUserEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}

final class AuthSignInUserEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInUserEvent({
    required this.email,
    required this.password,
  });
}

final class AuthGetCurrentUserEvent extends AuthEvent {
  const AuthGetCurrentUserEvent();
}
