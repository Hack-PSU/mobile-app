import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:hackpsu/data/authentication_repository.dart';
import 'package:hackpsu/models/email.dart';
import 'package:hackpsu/models/password.dart';
import 'package:hackpsu/models/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authenticationRepository) : super(const SignInState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String newEmail) {
    final email = Email.dirty(newEmail);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String newPassword) {
    final password = Password.dirty(newPassword);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInWithEmailAndPasswordError catch (e) {
      emit(
        state.copyWith(
          error: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
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
      await _authenticationRepository.signInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInWithGoogleError catch (e) {
      emit(
        state.copyWith(
          error: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
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
      await _authenticationRepository.signInWithGitHub(context);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInWithGithubError catch (e) {
      emit(
        state.copyWith(
          error: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
