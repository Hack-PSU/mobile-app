import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../common/api/event.dart';
import '../../common/api/hackathon/hackathon_model.dart';
import '../../common/api/hackathon/hackathon_repository.dart';
import '../../common/api/sponsorship/sponsor_model.dart';
import '../../common/api/sponsorship/sponsorship_repository.dart';
import '../../common/api/user.dart';
import '../../common/api/websocket.dart';

enum PageStatus { idle, loading, ready }

class HomePageCubitState {
  HomePageCubitState({
    this.events,
    this.sponsors,
    this.status = PageStatus.idle,
    this.workshops,
    this.hackathon,
  });

  final List<Event>? events;
  final List<Event>? workshops;
  final List<Sponsor>? sponsors;
  final Hackathon? hackathon;
  final PageStatus status;

  HomePageCubitState copyWith({
    List<Event>? events,
    List<Event>? workshops,
    List<Sponsor>? sponsors,
    PageStatus? status,
    Hackathon? hackathon,
  }) {
    return HomePageCubitState(
      events: events ?? this.events,
      sponsors: sponsors ?? this.sponsors,
      status: status ?? this.status,
      workshops: workshops ?? this.workshops,
      hackathon: hackathon ?? this.hackathon,
    );
  }
}

class HomePageCubit extends Cubit<HomePageCubitState> {
  HomePageCubit(
    EventRepository eventRepository,
    UserRepository userRepository,
    SponsorshipRepository sponsorshipRepository,
    HackathonRepository hackathonRepository,
  )   : _eventRepository = eventRepository,
        _userRepository = userRepository,
        _sponsorshipRepository = sponsorshipRepository,
        _hackathonRepository = hackathonRepository,
        super(
          HomePageCubitState(
            events: [],
            sponsors: [],
            workshops: [],
          ),
        ) {
    // Listen to specific events emitted from SocketManager
    // SocketManager.instance ensures singleton is used
    _socketSubscription = SocketManager.instance.socket.listen(
      (data) {
        switch (data.event) {
          case "update:hackathon": // fall through
          case "update:sponsorship": // fall through
          case "update:event":
            refetch();
            break;
        }
      },
    );
  }

  final EventRepository _eventRepository;
  final UserRepository _userRepository;
  final SponsorshipRepository _sponsorshipRepository;
  final HackathonRepository _hackathonRepository;
  late StreamSubscription<SocketData> _socketSubscription;

  Future<void> getEvents() async {
    try {
      final event = await _eventRepository.getEvents();
      emit(
        state.copyWith(
          events: event
              .where(
                (item) =>
                    item.type == EventType.ACTIVITY ||
                    item.type == EventType.FOOD,
              )
              .take(3)
              .toList(),
          workshops: event
              .where((item) => item.type == EventType.WORKSHOP)
              .take(3)
              .toList(),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
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

  Future<void> getHackathon() async {
    final hackathon = await _hackathonRepository.getActiveHackathon();
    emit(
      state.copyWith(
        hackathon: hackathon,
      ),
    );
  }

  Future<void> init() async {
    emit(state.copyWith(status: PageStatus.loading));
    await getHackathon();
    await getEvents();
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
