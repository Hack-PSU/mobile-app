import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../common/api/event.dart';
import '../../common/api/user.dart';
import '../../data/sponsorship_repository.dart';

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
  final List<Map<String, String>>? sponsors;
  final PageStatus status;

  HomePageCubitState copyWith({
    List<Event>? events,
    List<Event>? workshops,
    List<User>? users,
    List<Map<String, String>>? sponsors,
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
        );

  final EventRepository _eventRepository;
  final UserRepository _userRepository;
  final SponsorshipRepository _sponsorshipRepository;

  Future<void> getEvents() async {
    final event = await _eventRepository.getEvents();
    emit(
      state.copyWith(
        events: event,
        workshops: event
            .where((item) => item.eventType == EventType.WORKSHOP)
            .toList(),
      ),
    );
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
    emit(
      state.copyWith(
        sponsors: await _sponsorshipRepository.getSponsors(),
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
}
