import 'package:form_validator/form_validator.dart';
import 'package:formz/formz.dart';

enum PasswordError { valid, invalid }

class Password extends FormzInput<String, String> {
  Password.pure() : super.pure("");
  Password.dirty(String value) : super.dirty(value);

  static final passwordValidator = ValidationBuilder().minLength(1).build();

  @override
  String validator(String value) {
    return null;
  }
}
