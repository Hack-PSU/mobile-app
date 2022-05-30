import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'base_model.dart';
import 'email.dart';
import 'password.dart';

class CreateAccountState extends BaseModel {
  const CreateAccountState._({
    this.email,
    this.password,
    this.status,
    this.error,
  });

  CreateAccountState.initialize()
      : this._(
          email: Email.pure(),
          password: Password.pure(),
          error: "",
        );

  final Email? email;
  final Password? password;
  final FormzStatus? status;
  final String? error;

  CreateAccountState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? error,
  }) {
    return CreateAccountState._(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [email, password, status, error];

  @override
  bool isReady() {
    return true;
  }
}
