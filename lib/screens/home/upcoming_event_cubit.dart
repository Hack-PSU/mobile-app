import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../common/api/event.dart';

class UpcomingEventCubitState extends Equatable {
  const UpcomingEventCubitState._({
    this.events,
    this.upcomingEvents,
  });

  UpcomingEventCubitState.init(List<Event> events)
      : this._(
          events: events..sort((a, b) => a.startTime.compareTo(b.startTime)),
        );

  final List<Event>? events;
  final List<Event>? upcomingEvents;

  UpcomingEventCubitState copyWith({
    List<Event>? events,
    List<Event>? upcomingEvents,
  }) {
    return UpcomingEventCubitState._(
      events: events ?? this.events,
      upcomingEvents: upcomingEvents ?? this.upcomingEvents,
    );
  }

  UpcomingEventCubitState next() {
    if (events != null) {
      final upcomingEvents = events?.where((event) {
        final DateTime eventStart = event.startTime.add(
          const Duration(minutes: 15),
        );

        return eventStart.compareTo(events!.first.startTime) >= 0;
      }).toList();

      if (upcomingEvents != null) {
        return copyWith(upcomingEvents: upcomingEvents);
      }
    }
    return copyWith();
  }

  @override
  List<Object?> get props => [events, upcomingEvents];
}

class UpcomingEventCubit extends Cubit<UpcomingEventCubitState> {
  UpcomingEventCubit(List<Event> events)
      : super(UpcomingEventCubitState.init(events)) {
    emit(state.next());
    _timer = Timer.periodic(
      const Duration(minutes: 30),
      (timer) {
        if (state != null && state.events != null) {
          // find upcoming events every 30 minutes
          emit(state.next());
        }
      },
    );
  }

  late Timer _timer;

  @override
  Future<void> close() {
    // deallocate timer
    _timer.cancel();
    return super.close();
  }
}
