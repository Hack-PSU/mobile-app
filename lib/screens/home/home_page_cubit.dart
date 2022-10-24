import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../common/api/event.dart';
import '../../common/api/sponsorship/sponsor_model.dart';
import '../../common/api/sponsorship/sponsorship_repository.dart';
import '../../common/api/user.dart';
import '../../common/api/websocket.dart';

enum PageStatus { idle, loading, ready }

class HomePageCubitState {
  HomePageCubitState({
    this.events,
    this.users,
    this.sponsors,
    this.status = PageStatus.idle,
    this.workshops,
  });

  final List<Event>? events;
  final List<Event>? workshops;
  final List<User>? users;
  final List<Sponsor>? sponsors;
  final PageStatus status;

  HomePageCubitState copyWith({
    List<Event>? events,
    List<Event>? workshops,
    List<User>? users,
    List<Sponsor>? sponsors,
    PageStatus? status,
  }) {
    return HomePageCubitState(
      events: events ?? this.events,
      users: users ?? this.users,
      sponsors: sponsors ?? this.sponsors,
      status: status ?? this.status,
      workshops: workshops ?? this.workshops,
    );
  }
}

class HomePageCubit extends Cubit<HomePageCubitState> {
  HomePageCubit(
    EventRepository eventRepository,
    UserRepository userRepository,
    SponsorshipRepository sponsorshipRepository,
  )   : _eventRepository = eventRepository,
        _userRepository = userRepository,
        _sponsorshipRepository = sponsorshipRepository,
        super(
          HomePageCubitState(
            events: [],
            sponsors: [],
            users: [],
            workshops: [],
          ),
        ) {
    // Listen to specific events emitted from SocketManager
    // SocketManager.instance ensures singleton is used
    _socketSubscription = SocketManager.instance.socket.listen(
      (data) {
        switch (data.event) {
          case "update:event":
            print(data.data);
            break;
          default:
            print("DEFAULT");
            break;
        }
      },
    );
  }

  final EventRepository _eventRepository;
  final UserRepository _userRepository;
  final SponsorshipRepository _sponsorshipRepository;
  late StreamSubscription<SocketData> _socketSubscription;

  Future<void> getEvents() async {
    try {
      final event = await _eventRepository.getEvents();
      emit(
        state.copyWith(
          events: event,
          workshops: event
              .where((item) => item.eventType == EventType.WORKSHOP)
              .toList(),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserRegistrations() async {
    try {
      final users = await _userRepository.getUserRegistrations();
      emit(
        state.copyWith(
          users: users,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getSponsors() async {
    final sponsors = await _sponsorshipRepository.getAllSponsors();
    emit(
      state.copyWith(
        sponsors: sponsors
          ..sort(
            (a, b) => a.order.compareTo(b.order),
          ),
      ),
    );
  }

  Future<void> init() async {
    emit(state.copyWith(status: PageStatus.loading));
    await getEvents();
    await getUserRegistrations();
    await getSponsors();
    emit(state.copyWith(status: PageStatus.ready));
  }

  Future<void> refetch() async {
    emit(state.copyWith(status: PageStatus.idle));
  }

  @override
  Future<void> close() async {
    await _socketSubscription.cancel();
    return super.close();
  }
}
