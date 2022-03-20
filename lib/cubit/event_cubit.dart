import 'package:bloc/bloc.dart';
import '../../data/event_repository.dart';
import '../../models/event.dart';

class EventCubit extends Cubit<List<Event>> {
  EventCubit(EventRepository eventRepository)
      : _eventRepository = eventRepository,
        super(null);

  final EventRepository _eventRepository;

  Future<void> getEvents() async {
    final event = await _eventRepository.getEvents();
    emit(event);
  }

  Future<void> getEventsByType(EventType type) async {
    final events = await _eventRepository.getEvents();
    emit(events.where((e) => e.eventType == type).toList());
  }

  Future<void> filter(bool Function(Event item) predicate) async {
    final events = await _eventRepository.getEvents();
    emit(events.where(predicate).toList());
  }
}
