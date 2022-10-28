import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../common/api/event.dart';
import '../../common/api/websocket.dart';
import '../../common/bloc/favorites/favorites_bloc.dart';
import '../../common/bloc/favorites/favorites_event.dart';
import '../../common/bloc/favorites/favorites_state.dart';

enum PageStatus { idle, loading, ready }

class WorkshopsPageCubitState extends Equatable {
  const WorkshopsPageCubitState({
    this.workshops,
    this.favorites,
    this.status = PageStatus.idle,
    this.isFavoritesEnabled,
  });

  final List<Event>? workshops;
  final Set<String?>? favorites;
  final bool? isFavoritesEnabled;
  final PageStatus status;

  WorkshopsPageCubitState copyWith({
    List<Event>? workshops,
    Set<String?>? favorites,
    PageStatus? status,
    bool? isFavoritesEnabled,
  }) {
    return WorkshopsPageCubitState(
      workshops: workshops ?? this.workshops,
      favorites: favorites ?? this.favorites,
      status: status ?? this.status,
      isFavoritesEnabled: isFavoritesEnabled ?? this.isFavoritesEnabled,
    );
  }

  @override
  List<Object?> get props => [workshops, favorites, status, isFavoritesEnabled];
}

class WorkshopsPageCubit extends Cubit<WorkshopsPageCubitState> {
  WorkshopsPageCubit(
    EventRepository eventRepository,
    FavoritesBloc favoritesBloc,
  )   : _eventRepository = eventRepository,
        _favoritesBloc = favoritesBloc,
        super(
          const WorkshopsPageCubitState(workshops: [], favorites: {}),
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

  Future<void> getWorkshops() async {
    final events = await _eventRepository.getEvents();
    emit(
      state.copyWith(
        workshops: events
            .where((event) => event.eventType == EventType.WORKSHOP)
            .toList(),
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
              _favoritesBloc.state.status == FavoritesStatus.enabled),
    );
  }

  Future<void> init() async {
    emit(state.copyWith(status: PageStatus.loading));
    await getWorkshops();
    getFavorites();
    emit(state.copyWith(status: PageStatus.ready));
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
