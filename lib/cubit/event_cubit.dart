import 'package:bloc/bloc.dart';

import '../common/api/event.dart';

class EventCubit extends Cubit<List<Event>> {
  EventCubit(EventRepository eventRepository)
      : _eventRepository = eventRepository,
        super([]);

  final EventRepository _eventRepository;

  Future<void> getEvents() async {
    final event = await _eventRepository.getEvents();
    emit(event.where((item) => item.eventType != EventType.WORKSHOP).toList());
  }

  // wrapper function to execute a callback
  // the function ensures current state is flushed before executing
  Future<void> executeNew(Function() exec) async {
    emit([]);
    exec();
  }
}
