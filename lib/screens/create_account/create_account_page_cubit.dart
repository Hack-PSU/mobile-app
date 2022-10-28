import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

import '../../common/bloc/auth/auth_bloc.dart';
import '../../common/bloc/auth/auth_state.dart';
import '../../common/models/email.dart';
import '../../common/models/password.dart';
import '../../common/services/authentication_repository.dart';

class CreateAccountPageCubitState extends Equatable {
  const CreateAccountPageCubitState._({
    this.email,
    this.password,
    this.status,
    this.error,
  });

  CreateAccountPageCubitState.init()
      : this._(
          email: Email.pure(),
          password: Password.pure(),
          error: "",
        );

  final Email? email;
  final Password? password;
  final FormzStatus? status;
  final String? error;

  CreateAccountPageCubitState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? error,
  }) {
    return CreateAccountPageCubitState._(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [email, password, status, error];
}

class CreateAccountPageCubit extends Cubit<CreateAccountPageCubitState> {
  CreateAccountPageCubit(
    AuthenticationRepository authenticationRepository,
    AuthBloc authBloc,
  )   : _authenticationRepository = authenticationRepository,
        _authBloc = authBloc,
        super(
          CreateAccountPageCubitState.init(),
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
    if (state.email != null &&
        state.email?.value != null &&
        state.password != null &&
        state.password?.value != null) {
      try {
        await _authenticationRepository.signUp(
            email: state.email?.value ?? "",
            password: state.password?.value ?? "");
        if (_authBloc.state.status == AuthStatus.unauthenticated) {
          emit(
            state.copyWith(
              status: FormzStatus.submissionSuccess,
            ),
          );
        }
      } on SignUpWithEmailAndPasswordError catch (e) {
        if (kDebugMode) {
          print(e.message);
        }
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            error: e.message,
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
  }

  Future<void> signUpWithGoogle() async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );
    try {
      await _authenticationRepository.signInWithGoogle();
      if (_authBloc.state.status == AuthStatus.unauthenticated) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionSuccess,
          ),
        );
      }
    } on SignInWithGoogleError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      emit(
        state.copyWith(
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

  Future<void> signUpWithGitHub(BuildContext context) async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );
    try {
      await _authenticationRepository.signInWithGitHub(context);
      if (_authBloc.state.status == AuthStatus.unauthenticated) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionSuccess,
          ),
        );
      }
    } on SignInWithGithubError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      emit(
        state.copyWith(status: FormzStatus.submissionFailure, error: e.message),
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

  Future<void> signUpWithApple() async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );
    try {
      await _authenticationRepository.signInWithApple();
      if (_authBloc.state.status == AuthStatus.unauthenticated) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionSuccess,
          ),
        );
      }
    } on SignInWithGithubError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.message,
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
}
