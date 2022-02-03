import 'package:bloc/bloc.dart';
import 'package:hackpsu/data/event_repository.dart';
import 'package:hackpsu/models/event.dart';

class EventCubit extends Cubit<List<Event>> {
  EventCubit(EventRepository eventRepository)
      : _eventRepository = eventRepository,
        super(null);

  final EventRepository _eventRepository;

  Future<void> getEvents() async {
    final event = await _eventRepository.getEvents();
    emit(event);
  }
}
