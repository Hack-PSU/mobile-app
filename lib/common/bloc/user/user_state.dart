import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState._({
    this.pin,
    this.token,
    this.word_pin,
  });

  const UserState.initialize()
      : this._(
          token: "",
          pin: "",
          word_pin: "",
        );

  final String? token;
  final String? pin;
  final String? word_pin;

  UserState updateToken(String token) {
    return copyWith(
      token: token,
    );
  }

  // UserState updatePin(String pin) {
  //   return copyWith(
  //     pin: pin,
  //   );
  // }

  UserState updatePin(String pin, String word_pin) {
    return copyWith(
      pin: pin,
      word_pin: word_pin,
    );
  }

  UserState copyWith({
    String? token,
    String? pin,
    String? word_pin,
  }) {
    return UserState._(
      token: token ?? this.token,
      pin: pin ?? this.pin,
      word_pin: word_pin ?? this.word_pin,
    );
  }

  @override
  List<Object?> get props => [token, pin, word_pin];
}
