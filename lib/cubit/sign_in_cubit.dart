import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../common/bloc/auth/auth_bloc.dart';
import '../common/bloc/auth/auth_event.dart';
import '../common/bloc/auth/auth_state.dart';
import '../data/authentication_repository.dart';
import '../models/email.dart';
import '../models/password.dart';
import '../models/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    this._authenticationRepository,
    this._authBloc,
  ) : super(const SignInState());

  final AuthenticationRepository _authenticationRepository;
  final AuthBloc _authBloc;

  void emailChanged(String newEmail) {
    final email = Email.dirty(newEmail);

    emit(
      state.copyWith(
        email: email,
        // status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String newPassword) {
    final password = Password.dirty(newPassword);
    emit(
      state.copyWith(
        password: password,
        // status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    // if (!state.status.isValidated) return;
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );
    try {
      _authBloc.add(AuthVerifying());
      await _authenticationRepository.signInWithEmailAndPassword(
        email: state.email!.value,
        password: state.password!.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInWithEmailAndPasswordError catch (e) {
      _authBloc.add(AuthError());
      print(e.message);
      emit(
        state.copyWith(
          error: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      _authBloc.add(AuthVerifying());
      await _authenticationRepository.signInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInWithGoogleError catch (e) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          error: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> signInWithGitHub(BuildContext context) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      // _authBloc.add(AuthVerifying());
      await _authenticationRepository.signInWithGitHub(context);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInWithGithubError catch (e) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          error: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> signInWithApple() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      _authBloc.add(AuthVerifying());
      await _authenticationRepository.signInWithApple();
      if (_authBloc.state.status == AuthStatus.unauthenticated) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
    } on SignInWithAppleError catch (e) {
      _authBloc.add(AuthError());
      emit(
        state.copyWith(
          error: e.message,
          status: FormzStatus.submissionFailure,
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

  Future<void> forgotPassword() async {
    await _authenticationRepository.launchURLApp();
  }
}
