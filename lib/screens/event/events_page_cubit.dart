import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../common/api/event.dart';
import '../../common/api/websocket.dart';
import '../../common/bloc/favorites/favorites_bloc.dart';
import '../../common/bloc/favorites/favorites_event.dart';
import '../../common/bloc/favorites/favorites_state.dart';

enum PageStatus { idle, loading, ready }

class EventsPageCubitState extends Equatable {
  const EventsPageCubitState({
    this.events,
    this.favorites,
    this.status = PageStatus.idle,
    this.isFavoritesEnabled,
  });

  final List<Event>? events;
  final Set<String?>? favorites;
  final bool? isFavoritesEnabled;
  final PageStatus status;

  EventsPageCubitState copyWith({
    List<Event>? events,
    Set<String?>? favorites,
    PageStatus? status,
    bool? isFavoritesEnabled,
  }) {
    return EventsPageCubitState(
      events: events ?? this.events,
      favorites: favorites ?? this.favorites,
      status: status ?? this.status,
      isFavoritesEnabled: isFavoritesEnabled ?? this.isFavoritesEnabled,
    );
  }

  @override
  List<Object?> get props => [events, favorites, status, isFavoritesEnabled];
}

class EventsPageCubit extends Cubit<EventsPageCubitState> {
  EventsPageCubit(
    EventRepository eventRepository,
    FavoritesBloc favoritesBloc,
  )   : _eventRepository = eventRepository,
        _favoritesBloc = favoritesBloc,
        super(
          const EventsPageCubitState(
            events: [],
            favorites: {},
          ),
        ) {
    _socketSubscription = SocketManager.instance.socket.listen((data) {
      switch (data.event) {
        case "update:hackathon":
        case "update:event":
          refetch();
          break;
      }
    });
  }

  final EventRepository _eventRepository;
  final FavoritesBloc _favoritesBloc;
  late final StreamSubscription<SocketData> _socketSubscription;

  Future<void> getEvents() async {
    final events = await _eventRepository.getEvents();
    emit(
      state.copyWith(
        events:
            events.where((event) => event.type != EventType.WORKSHOP).toList(),
      ),
    );
  }

  void markFavorite(Event event) {
    _favoritesBloc.add(AddFavoritesItem(event));
  }

  void unmarkFavorite(Event event) {
    _favoritesBloc.add(RemoveFavoritesItem(event));
  }

  void toggleFavorites(bool? enable) {
    if (enable != null) {
      emit(
        state.copyWith(
          isFavoritesEnabled: enable,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isFavoritesEnabled: !(state.isFavoritesEnabled ?? true),
        ),
      );
    }
  }

  void setFavorites(Set<String?>? favorites) {
    emit(
      state.copyWith(favorites: favorites),
    );
  }

  void getFavorites() {
    emit(
      state.copyWith(
        favorites: _favoritesBloc.state.items,
        isFavoritesEnabled:
            _favoritesBloc.state.status == FavoritesStatus.enabled,
      ),
    );
  }

  Future<void> init() async {
    emit(state.copyWith(status: PageStatus.loading));
    await getEvents();
    getFavorites();
    emit(
      state.copyWith(
        status: PageStatus.ready,
      ),
    );
  }

  void refetch() {
    emit(state.copyWith(status: PageStatus.idle));
  }

  void refreshFavoritesStatus() {
    emit(
      state.copyWith(
        isFavoritesEnabled:
            _favoritesBloc.state.status == FavoritesStatus.enabled,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _socketSubscription.cancel();
    super.close();
  }
}
