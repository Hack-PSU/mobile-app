import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState._({
    this.pin,
    this.token,
  });

  const UserState.initialize()
      : this._(
          token: "",
          pin: "",
        );

  final String token;
  final String pin;

  UserState updateToken(String token) {
    return copyWith(
      token: token,
    );
  }

  UserState updatePin(String pin) {
    return copyWith(
      pin: pin,
    );
  }

  UserState copyWith({
    String token,
    String pin,
  }) {
    return UserState._(
      token: token ?? this.token,
      pin: pin ?? this.pin,
    );
  }

  @override
  List<Object> get props => [token, pin];
}
