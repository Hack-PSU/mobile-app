import 'package:flutter/cupertino.dart';
import 'package:form_validator/form_validator.dart';
import 'package:formz/formz.dart';

enum EmailStatus { valid, invalid }

class EmailValidation {
  const EmailValidation([
    this.status,
    this.message,
  ]);

  final EmailStatus status;
  final String message;
}

class Email extends FormzInput<String, String> {
  Email.pure() : super.pure("");
  Email.dirty(String value) : super.dirty(value);

  static final emailValidator =
      ValidationBuilder().email("Invalid email").build();

  @override
  String validator(String email) {
    return null;
  }
}
