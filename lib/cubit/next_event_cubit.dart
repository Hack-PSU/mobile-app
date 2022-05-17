import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';

import '../models/event.dart';
import '../models/next_event_state.dart';

class NextEventCubit extends Cubit<NextEventState> {
  NextEventCubit(List<Event> events)
      : super(
          NextEventState.initialize(
            groupBy<Event, int>(
              events,
              (event) => event.eventStartTime.millisecondsSinceEpoch,
            ),
          ),
        ) {
    emit(state.next());
    _timer = Timer.periodic(
      const Duration(minutes: 30),
      (timer) {
        if (state != null && state.events != null) {
          // Run next event every 30 minutes
          emit(state.next());
        }
      },
    );
  }

  late Timer _timer;

  @override
  Future<void> close() {
    // Deallocate timer
    _timer.cancel();
    return super.close();
  }
}
