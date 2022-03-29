import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  const NotificationState._({
    this.pin,
    this.token,
  });

  const NotificationState.initialize()
      : this._(
          token: "",
          pin: "",
        );

  final String token;
  final String pin;

  NotificationState updateToken(String token) {
    return copyWith(
      token: token,
    );
  }

  NotificationState updatePin(String pin) {
    return copyWith(
      pin: pin,
    );
  }

  NotificationState copyWith({
    String token,
    String pin,
  }) {
    return NotificationState._(
      token: token ?? this.token,
      pin: pin ?? this.pin,
    );
  }

  @override
  List<Object> get props => [];
}
