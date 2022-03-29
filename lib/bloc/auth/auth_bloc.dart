import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/authentication_repository.dart';
import '../../data/notification_repository.dart';
import '../../data/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    @required AuthenticationRepository authenticationRepository,
    @required NotificationRepository notificationRepository,
    @required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _notificationRepository = notificationRepository,
        _userRepository = userRepository,
        super(
          authenticationRepository.currentUser != null
              ? AuthState.authenticated(authenticationRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthLogout>(_onAuthLogout);
    on<AuthVerifying>(_onAuthVerifying);
    on<AuthError>(_onAuthError);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final NotificationRepository _notificationRepository;
  final UserRepository _userRepository;

  StreamSubscription<User> _userSubscription;

  Future<void> _onAuthUserChanged(
      AuthUserChanged event, Emitter<AuthState> emit) async {
    if (event.user != null) {
      final pin = await _userRepository.getUserPin();
      print("PIN: $pin");
      await _notificationRepository.register(pin);
    }
    emit(
      event.user != null
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  void _onAuthVerifying(AuthVerifying event, Emitter<AuthState> emit) {
    emit(const AuthState.verifying());
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) {
    _authenticationRepository.signOut();
  }

  void _onAuthError(AuthError event, Emitter<AuthState> emit) {
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
