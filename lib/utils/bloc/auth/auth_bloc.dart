import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackpsu/data/authentication_repository.dart';
import 'package:hackpsu/utils/bloc/auth/auth_event.dart';
import 'package:hackpsu/utils/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser != null
              ? AuthState.authenticated(authenticationRepository.currentUser)
              : AuthState.unauthenticated(),
        ) {
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthLogout>(_onAuthLogout);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User> _userSubscription;

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    emit(
      event.user != null
          ? AuthState.authenticated(event.user)
          : AuthState.unauthenticated(),
    );
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) {
    unawaited(_authenticationRepository.signOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
