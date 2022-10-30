import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

import '../../common/bloc/auth/auth_bloc.dart';
import '../../common/models/email.dart';
import '../../common/models/password.dart';
import '../../common/services/authentication_repository.dart';

class SignInPageCubitState extends Equatable {
  const SignInPageCubitState._({
    this.email,
    this.password,
    this.status,
    this.error,
  });

  SignInPageCubitState.init()
      : this._(
          email: Email.pure(),
          password: Password.pure(),
          status: FormzStatus.pure,
          error: null,
        );

  final Email? email;
  final Password? password;
  final FormzStatus? status;
  final String? error;

  SignInPageCubitState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? error,
  }) {
    return SignInPageCubitState._(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [email, password, status, error];
}

class SignInPageCubit extends Cubit<SignInPageCubitState> {
  SignInPageCubit(
      AuthenticationRepository authenticationRepository, AuthBloc authBloc)
      : _authenticationRepository = authenticationRepository,
        _authBloc = authBloc,
        super(
          SignInPageCubitState.init(),
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

  Future<void> signInWithEmailAndPassword() async {
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );
    if (state.email != null &&
        state.email?.value != null &&
        state.password != null &&
        state.password?.value != null) {
      try {
        await _authenticationRepository.signInWithEmailAndPassword(
          email: state.email?.value ?? "",
          password: state.password?.value ?? "",
        );
        emit(
          state.copyWith(
            status: FormzStatus.submissionSuccess,
          ),
        );
      } on SignInWithEmailAndPasswordError catch (e) {
        emit(
          state.copyWith(
            error: e.message,
            status: FormzStatus.submissionFailure,
          ),
        );
        if (kDebugMode) {
          print(e.message);
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
          ),
        );
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  Future<void> sendPasswordResetEmail() async {
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );
    if (state.email != null && state.email?.value != null) {
      try {
        await _authenticationRepository.sendPasswordResetEmail(
            email: state.email?.value ?? "");
        emit(
          state.copyWith(
            status: FormzStatus.submissionSuccess,
          ),
        );
      } on SendPasswordResetEmailError catch (e) {
        emit(
          state.copyWith(
            error: e.message,
            status: FormzStatus.submissionFailure,
          ),
        );
        if (kDebugMode) {
          print(e.message);
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
          ),
        );
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  Future<void> signInWithGoogle() async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );
    try {
      await _authenticationRepository.signInWithGoogle();
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on SignInWithGoogleError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      emit(
        state.copyWith(
          error: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> signInWithGitHub(BuildContext context) async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );
    try {
      await _authenticationRepository.signInWithGitHub(context);
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on SignInWithGithubError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      emit(
        state.copyWith(
          error: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> signInWithApple() async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );
    try {
      await _authenticationRepository.signInWithApple();
      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    } on SignInWithAppleError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      emit(
        state.copyWith(
          error: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
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
