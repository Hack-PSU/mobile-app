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
}