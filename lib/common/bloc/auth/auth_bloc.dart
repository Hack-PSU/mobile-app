import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../api/websocket.dart';
import '../../services/authentication_repository.dart';
import '../app/app_bloc.dart';
import '../user/user_bloc.dart';
import '../user/user_event.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthenticationRepository authenticationRepository,
    required UserBloc userBloc,
    required AppBloc appBloc,
  })  : _authenticationRepository = authenticationRepository,
        _userBloc = userBloc,
        _appBloc = appBloc,
        super(
          authenticationRepository.currentUser != null
              ? AuthState.authenticated(authenticationRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthLogout>(_onAuthLogout);
    on<AuthAuthenticated>(_onAuthAuthenticated);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserBloc _userBloc;
  final AppBloc _appBloc;

  late StreamSubscription<User?> _userSubscription;

  Future<void> _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user != null && _appBloc.state.isConnected == true) {
      await SocketManager.instance.connect();
      _userBloc.add(const RegisterUser());
    }

    if (event.user == null) {
      SocketManager.instance.dispose();
    }

    emit(
      event.user != null
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  Future<void> _onAuthAuthenticated(
    AuthAuthenticated event,
    Emitter<AuthState> emit,
  ) async {
    if (_authenticationRepository.currentUser != null) {
      _userBloc.add(const RegisterUser());
    }
    emit(
      _authenticationRepository.currentUser != null
          ? AuthState.authenticated(_authenticationRepository.currentUser)
          : const AuthState.unauthenticated(),
    );
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) {
    _authenticationRepository.signOut();
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    SocketManager.instance.dispose();
    return super.close();
  }
}
