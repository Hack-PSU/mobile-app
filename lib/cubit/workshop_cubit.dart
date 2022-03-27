import 'package:bloc/bloc.dart';
import '../../data/event_repository.dart';
import '../../models/event.dart';

class WorkshopCubit extends Cubit<List<Event>> {
  WorkshopCubit(EventRepository eventRepository)
      : _eventRepository = eventRepository,
        super(null);

  final EventRepository _eventRepository;

  Future<void> getWorkshops() async {
    final event = await _eventRepository.getEventsByType(EventType.WORKSHOP);
    emit(event);
  }

  Future<void> getEventsByType(EventType type) async {
    final events = await _eventRepository.getEvents();
    final filteredEvents = events.where((e) => e.eventType == type).toList();
    emit(filteredEvents);
  }

  Future<void> filter(bool Function(Event item) predicate) async {
    final events = await _eventRepository.getEvents();
    emit(events.where(predicate).toList());
  }

  // wrapper function to execute a callback
  // the function ensures current state is flushed before executing
  Future<void> executeNew(Function() exec) async {
    emit(null);
    exec();
  }
}
