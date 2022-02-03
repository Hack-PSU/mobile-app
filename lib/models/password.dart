import 'package:form_validator/form_validator.dart';
import 'package:formz/formz.dart';

enum PasswordError { valid, invalid }
enum ValidatorMode { number, upperCase, lowerCase, length, symbol }

// class PasswordValidation {
//   const PasswordValidation([
//     this.status,
//     this.error,
//   ]);
//
//   final PasswordStatus status;
//   final String error;
//
//   const PasswordValidation.fromTest(String value, Function(String) validator, PasswordStatus errorType) :
//       this((validator(value) != null) ? PasswordStatus.valid : errorType, )
//
//   // static PasswordValidation fromTest(
//   //     String value, Function(String) validator, PasswordStatus errorType) {
//   //   final valid = validator(value);
//   //   if (valid == null) {
//   //     return PasswordValidation(PasswordStatus.valid);
//   //   } else {
//   //     return PasswordValidation(errorType, valid);
//   //   }
//   // }
// }

class Password extends FormzInput<String, PasswordError> {
  Password.pure() : super.pure("");
  Password.dirty(String value) : super.dirty(value);

  static final passwordValidator = ValidationBuilder().minLength(1).build();

  @override
  PasswordError validator(String value) {
    final valid = passwordValidator(value);

    if (valid == null) {
      return PasswordError.valid;
    } else {
      return PasswordError.invalid;
    }
  }

  // static final validateNumber = ValidationBuilder()
  //     .regExp(
  //       RegExp("[0-9]"),
  //       "At least 1 number",
  //     )
  //     .build();
  //
  // static final validateUpperCase = ValidationBuilder()
  //     .regExp(
  //       RegExp("[A-Z]"),
  //       "At least 1 uppercase letter",
  //     )
  //     .build();
  //
  // static final validateLowerCase = ValidationBuilder()
  //     .regExp(
  //       RegExp("[a-z]"),
  //       "At least 1 lowercase letter",
  //     )
  //     .build();
  //
  // static final validateLength = ValidationBuilder().minLength(8).build();
  //
  // static final validateSymbol = ValidationBuilder()
  //     .regExp(
  //       RegExp("[^A-Za-z0-9]"),
  //       "At least 1 special symbol",
  //     )
  //     .build();
  //
  // @override
  // List<PasswordValidation> validator(String password) {
  //   final validNumber = validateNumber(password);
  //   final validUpperCase = validateUpperCase(password);
  //   final validLowerCase = validateLowerCase(password);
  //   final validLength = validateLength(password);
  //   final validSymbol = validateSymbol(password);
  //
  //   List<String> errors = [
  //     PasswordValidation.fromTest(),
  //     validUpperCase,
  //     validLowerCase,
  //     validLength,
  //     validLength,
  //     validSymbol
  //   ];
  //
  //   errors.removeWhere((e) => e == null);
  //
  //   if (errors.isNotEmpty) {}
  // }
}
