import 'package:equatable/equatable.dart';

class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class RefreshToken extends NotificationEvent {
  const RefreshToken([
    this.token = "",
  ]);

  final String token;

  @override
  List<Object> get props => [token];
}

class SubscribeTopic extends NotificationEvent {
  const SubscribeTopic({
    this.topic,
  });

  final String topic;

  @override
  List<Object> get props => [topic];
}

class UnsubscribeTopic extends NotificationEvent {
  const UnsubscribeTopic({
    this.topic,
  });

  final String topic;

  @override
  List<Object> get props => [topic];
}
