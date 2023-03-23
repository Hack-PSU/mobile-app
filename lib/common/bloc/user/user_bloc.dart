import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../api/notification.dart';
import '../../api/user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
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
      if (state.uid != "") {
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
      final uid = await _userRepository.getUserUid();
      emit(state.copyWith(uid: uid));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    // register user into FCM
    if (state.uid != "") {
      try {
        if (event.token != "") {
          await _notificationRepository.register(state.uid, event.token);
          emit(state.copyWith(token: event.token));
        } else {
          await _notificationRepository.register(state.uid);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        throw Exception("Unable to register device");
      }
    }

    // subscribe user to broadcast
    if (state.uid != "") {
      try {
        await _notificationRepository.subscribeAll(state.uid);
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
    await _notificationRepository.subscribeEvent(state.uid, event.topic);
  }

  Future<void> _onUnsubscribeTopic(
    UnsubscribeTopic event,
    Emitter<UserState> emit,
  ) async {
    if (kDebugMode) {
      print(event.topic);
    }
    await _notificationRepository.unsubscribeEvent(state.uid, event.topic);
  }

  @override
  Future<void> close() {
    _tokenSubscription.cancel();
    return super.close();
  }

  @override
  UserState fromJson(Map<String, dynamic> json) => UserState.fromJson(json);

  @override
  Map<String, dynamic> toJson(UserState state) => state.toJson();
}
