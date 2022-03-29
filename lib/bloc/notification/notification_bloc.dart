import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/notification_repository.dart';
import '../../data/user_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({
    @required UserRepository userRepository,
    @required NotificationRepository notificationRepository,
  })  : _notificationRepository = notificationRepository,
        _userRepository = userRepository,
        super(
          const NotificationState.initialize(),
        ) {
    on<SubscribeTopic>(_onSubscribeTopic);
    on<UnsubscribeTopic>(_onUnsubscribeTopic);
    on<RefreshToken>(_onRefreshToken);
    _tokenSubscription = _notificationRepository.onTokenRefresh.listen((token) {
      if (state.pin != "") {
        add(RefreshToken(token));
      }
    });
  }

  final UserRepository _userRepository;
  final NotificationRepository _notificationRepository;
  StreamSubscription<String> _tokenSubscription;

  Future<void> _onRefreshToken(
    RefreshToken event,
    Emitter<NotificationState> emit,
  ) async {
    if (state.pin == "") {
      try {
        final userPin = await _userRepository.getUserPin();
        emit(state.updatePin(userPin));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        throw Exception("Unable to fetch user pin");
      }
    }

    if (state.pin != "") {
      try {
        if (event.token != "") {
          await _notificationRepository.register(state.pin, event.token);
          emit(state.updateToken(event.token));
        } else {
          await _notificationRepository.register(state.pin);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        throw Exception("Unable to register device");
      }
    }

    if (state.pin != "") {
      try {
        await _notificationRepository.subscribeAll(state.pin);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        throw Exception("Unable to subscribe to broadcast onRefresh");
      }
    }
  }

  Future<void> _onSubscribeTopic(
    SubscribeTopic event,
    Emitter<NotificationState> emit,
  ) async {
    await _notificationRepository.subscribeEvent(state.pin, event.topic);
  }

  Future<void> _onUnsubscribeTopic(
    UnsubscribeTopic event,
    Emitter<NotificationState> emit,
  ) async {
    await _notificationRepository.subscribeEvent(state.pin, event.topic);
  }

  @override
  Future<void> close() {
    _tokenSubscription.cancel();
    return super.close();
  }
}
