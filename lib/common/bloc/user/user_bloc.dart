import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../api/event.dart';
import '../../api/notification.dart';
import '../../api/user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc({
    required UserRepository userRepository,
    required EventRepository eventRepository,
    required NotificationRepository notificationRepository,
  })  : _notificationRepository = notificationRepository,
        _userRepository = userRepository,
        _eventRepository = eventRepository,
        super(
          const UserState.initialize(),
        ) {
    on<SubscribeTopic>(_onSubscribeTopic);
    on<UnsubscribeTopic>(_onUnsubscribeTopic);
    on<RegisterUser>(_onRegisterUser);
    _tokenSubscription = _notificationRepository.onTokenRefresh.listen((token) {
      add(RegisterUser(token));
    });
  }

  final UserRepository _userRepository;
  final EventRepository _eventRepository;
  final NotificationRepository _notificationRepository;
  late StreamSubscription<String> _tokenSubscription;

  Future<void> _onRegisterUser(
    RegisterUser event,
    Emitter<UserState> emit,
  ) async {
    // get user profile
    final user = await _userRepository.getUserProfile();

    if (user != null) {
      emit(state.copyWith(profile: user, userId: user.id));
    }

    // register user into FCM
    try {
      if (event.token != "") {
        await _notificationRepository.register(event.token);
        emit(state.copyWith(token: event.token));
      } else {
        await _notificationRepository.register();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Unable to register device");
    }
  }

  Future<void> _onSubscribeTopic(
    SubscribeTopic event,
    Emitter<UserState> emit,
  ) async {
    if (kDebugMode) {
      print(event.topic);
    }
    if (event.topic != null) {
      await _eventRepository.subscribeTo(event.topic!);
    }
  }

  Future<void> _onUnsubscribeTopic(
    UnsubscribeTopic event,
    Emitter<UserState> emit,
  ) async {
    if (kDebugMode) {
      print(event.topic);
    }
    if (event.topic != null) {
      await _eventRepository.unsubscribeFrom(event.topic!);
    }
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
