import 'package:collection/collection.dart' show IterableExtension;
import 'package:equatable/equatable.dart';

import 'event.dart';

class NextEventState extends Equatable {
  const NextEventState._({
    this.events,
    this.nextEvents,
  });

  const NextEventState.initialize(Map<int, List<Event>> events)
      : this._(
          events: events,
        );

  final List<Event>? nextEvents;
  final Map<int, List<Event>>? events;

  NextEventState copyWith({
    Map<int, List<Event>>? events,
    List<Event>? nextEvents,
  }) {
    return NextEventState._(
      events: events ?? this.events,
      nextEvents: nextEvents ?? this.nextEvents,
    );
  }

  NextEventState next() {
    if (events != null) {
      final nextGroup = events!.keys.firstWhereOrNull(
        (event) {
          final DateTime start = DateTime.fromMillisecondsSinceEpoch(event);
          final DateTime eventStart = start.add(const Duration(minutes: 15));

          return eventStart.compareTo(DateTime.now()) >= 0;
        },
      ); // define orElse so error is not thrown when all false
      if (nextGroup != null) {
        return copyWith(nextEvents: events![nextGroup]);
      }
    }
    return copyWith();
    // if (events != null) {
    //   final nextEvents = events.where(
    //     (event) {
    //       final DateTime eventStart = event.eventStartTime.add(
    //         const Duration(
    //           minutes: 15,
    //         ),
    //       );
    //       return eventStart.compareTo(DateTime.now()) >= 0;
    //     },
    //   );
    //   return copyWith(nextEvents: nextEvents.toList());
    // }
    //   for (final Event event in events) {
    //     final DateTime eventStart = event.eventStartTime.add(
    //       const Duration(
    //         minutes: 15,
    //       ),
    //     );
    //     if (eventStart.compareTo(DateTime.now()) >= 0) {
    //       return copyWith(nextEvents: event);
    //     }
    //   }
    // }
    // return copyWith();
  }

  @override
  List<Object?> get props => [events, nextEvents];
}
