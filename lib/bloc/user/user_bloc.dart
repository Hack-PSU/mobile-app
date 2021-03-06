import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/notification_repository.dart';
import '../../data/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required UserRepository userRepository,
    required NotificationRepository notificationRepository,
  })  : _notificationRepository = notificationRepository,
        _userRepository = userRepository,
        super(
          const UserState.initialize(),
        ) {
    on<SubscribeTopic>(_onSubscribeTopic);
    on<UnsubscribeTopic>(_onUnsubscribeTopic);
    on<RegisterUser>(_onRegisterUser);
    _tokenSubscription = _notificationRepository.onTokenRefresh.listen((token) {
      if (state.pin != "") {
        add(RegisterUser(token));
      }
    });
  }

  final UserRepository _userRepository;
  final NotificationRepository _notificationRepository;
  late StreamSubscription<String> _tokenSubscription;

  Future<void> _onRegisterUser(
    RegisterUser event,
    Emitter<UserState> emit,
  ) async {
    // get user pin
    try {
      final userPin = await _userRepository.getUserPin();
      emit(state.updatePin(userPin));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Unable to fetch user pin");
    }

    // register user into FCM
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

    // subscribe user to broadcast
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
    Emitter<UserState> emit,
  ) async {
    if (kDebugMode) {
      print(event.topic);
    }
    await _notificationRepository.subscribeEvent(state.pin, event.topic);
  }

  Future<void> _onUnsubscribeTopic(
    UnsubscribeTopic event,
    Emitter<UserState> emit,
  ) async {
    if (kDebugMode) {
      print(event.topic);
    }
    await _notificationRepository.unsubscribeEvent(state.pin, event.topic);
  }

  @override
  Future<void> close() {
    _tokenSubscription.cancel();
    return super.close();
  }
}
