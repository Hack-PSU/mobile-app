import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../data/authentication_repository.dart';
import '../models/create_account_state.dart';
import '../models/email.dart';
import '../models/password.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit({
    @required AuthenticationRepository authenticationRepository,
    @required AuthBloc authBloc,
  })  : _authenticationRepository = authenticationRepository,
        _authBloc = authBloc,
        super(
          CreateAccountState.initialize(),
        );

  final AuthenticationRepository _authenticationRepository;
  final AuthBloc _authBloc;

  void onEmailChanged(String newEmail) {
    emit(
      state.copyWith(
        email: Email.dirty(newEmail),
      ),
    );
  }

  void onPasswordChanged(String newPassword) {
    emit(
      state.copyWith(
        password: Password.dirty(newPassword),
      ),
    );
  }

  Future<void> signUpWithEmailAndPassword() async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );
    try {
      _authBloc.add(AuthVerifying());
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      if (_authBloc.state.status == AuthStatus.unauthenticated) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
    } on SignUpWithEmailAndPasswordError catch (e) {
      print(e.message);
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.message,
        ),
      );
      _authBloc.add(AuthError());
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
      _authBloc.add(AuthError());
    }
  }

  Future<void> signUpWithGoogle() async {
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );
    try {
      _authBloc.add(AuthVerifying());
      await _authenticationRepository.signInWithGoogle();
      if (_authBloc.state.status == AuthStatus.unauthenticated) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
    } on SignInWithGoogleError catch (e) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.message,
        ),
      );
    } catch (e) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> signUpWithGitHub(BuildContext context) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      _authBloc.add(AuthVerifying());
      await _authenticationRepository.signInWithGitHub(context);
      if (_authBloc.state.status == AuthStatus.unauthenticated) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
    } on SignInWithGithubError catch (e) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.message,
        ),
      );
    } catch (e) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> signUpWithApple() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      _authBloc.add(AuthVerifying());
      await _authenticationRepository.signInWithApple();
      if (_authBloc.state.status == AuthStatus.unauthenticated) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
    } on SignInWithGithubError catch (e) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.message,
        ),
      );
    } catch (e) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
