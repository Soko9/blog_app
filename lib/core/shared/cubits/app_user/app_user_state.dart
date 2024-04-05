part of "app_user_cubit.dart";

@immutable
sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {
  const AppUserInitial();
}

final class AppUserLoggedIn extends AppUserState {
  final Profile profile;
  const AppUserLoggedIn({required this.profile});
}
