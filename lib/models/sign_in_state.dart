import 'package:formz/formz.dart';
import 'base_model.dart';
import 'email.dart';
import 'password.dart';

class SignInState extends BaseModel {
  const SignInState({
    this.email,
    this.password,
    this.status,
    this.error,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String error;

  @override
  List<Object> get props => [email, password, status];

  SignInState copyWith({
    Email email,
    Password password,
    FormzStatus status,
    String error,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
