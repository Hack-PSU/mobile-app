import 'package:bloc/bloc.dart';
import '../../data/event_repository.dart';
import '../../models/event.dart';

class EventCubit extends Cubit<List<Event>> {
  EventCubit(EventRepository eventRepository)
      : _eventRepository = eventRepository,
        super([]);

  final EventRepository _eventRepository;

  Future<void> getEvents() async {
    final event = await _eventRepository
        .filter((item) => item.eventType != EventType.WORKSHOP);
    emit(event);
  }

  // wrapper function to execute a callback
  // the function ensures current state is flushed before executing
  Future<void> executeNew(Function() exec) async {
    emit([]);
    exec();
  }
}
