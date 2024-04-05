import "dart:async";

import "package:blog_app/core/shared/cubits/app_user/app_user_cubit.dart";
import "package:blog_app/features/auth/domain/usecases/get_current_user.dart";

import "../../../../core/resources/usecase.dart";
import "../../../../core/shared/entities/profile.dart";
import "../../domain/usecases/sign_in_user.dart";
import "../../domain/usecases/sign_up_user.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUser _signUpUser;
  final SignInUser _signInUser;
  final GetCurrentUser _getCurrentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required SignUpUser signUpUserUsecase,
    required SignInUser signInUserUsecase,
    required GetCurrentUser getCurrentUserUsecase,
    required AppUserCubit appUserCubit,
  })  : _signUpUser = signUpUserUsecase,
        _signInUser = signInUserUsecase,
        _getCurrentUser = getCurrentUserUsecase,
        _appUserCubit = appUserCubit,
        super(
          const AuthInitial(),
        ) {
    on<AuthEvent>((_, emit) => emit(const AuthLoading()));
    on<AuthSignUpUserEvent>(_signUpEvent);
    on<AuthSignInUserEvent>(_signInEvent);
    on<AuthGetCurrentUserEvent>(_getCurrentUserEvent);
  }

  FutureOr<void> _signUpEvent(
    AuthSignUpUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signUpUser(
      params: SignUpUserParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    result.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => _successEmitter(profile: r, emitter: emit),
    );
  }

  FutureOr<void> _signInEvent(
    AuthSignInUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signInUser(
      params: SignInUserParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => _successEmitter(profile: r, emitter: emit),
    );
  }

  FutureOr<void> _getCurrentUserEvent(
    AuthGetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getCurrentUser(params: NoParams());

    result.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => _successEmitter(profile: r, emitter: emit),
    );
  }

  void _successEmitter({
    required Profile profile,
    required Emitter<AuthState> emitter,
  }) {
    _appUserCubit.updateUserState(profile: profile);
    emitter(AuthSuccess(profile: profile));
  }
}
