import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../data/authentication_repository.dart';
import '../models/create_account_state.dart';
import '../models/email.dart';
import '../models/password.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit({
    @required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          CreateAccountState.initialize(),
        );

  final AuthenticationRepository _authenticationRepository;

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
      await _authenticationRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInWithEmailAndPasswordError catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> signUpWithGoogle() async {
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );
    try {
      await _authenticationRepository.signInWithGoogle();
      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    } on SignInWithGoogleError catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.message,
        ),
      );
    } catch (e) {
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
      await _authenticationRepository.signInWithGitHub(context);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInWithGithubError catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
