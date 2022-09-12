import 'package:equatable/equatable.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class RegisterUser extends UserEvent {
  const RegisterUser([
    this.token = "",
  ]);

  final String token;

  @override
  List<Object> get props => [token];
}

class SubscribeTopic extends UserEvent {
  const SubscribeTopic({
    this.topic,
  });

  final String? topic;

  @override
  List<Object?> get props => [topic];
}

class UnsubscribeTopic extends UserEvent {
  const UnsubscribeTopic({
    this.topic,
  });

  final String? topic;

  @override
  List<Object?> get props => [topic];
}
