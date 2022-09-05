import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../user/user_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends HydratedBloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required UserBloc userBloc,
  })  : _userBloc = userBloc,
        super(
          FavoritesState.initialize(),
        ) {
    on<EnableFavorites>(_onEnableFavorites);
    on<DisableFavorites>(_onDisableFavorites);
    on<AddFavoritesItem>(_onAddFavoritesItem);
    on<RemoveFavoritesItem>(_onRemoveFavoritesItem);
  }

  final UserBloc _userBloc;

  void _onEnableFavorites(EnableFavorites event, Emitter<FavoritesState> emit) {
    emit(state.copyWith(status: FavoritesStatus.enabled));
  }

  void _onDisableFavorites(
    DisableFavorites event,
    Emitter<FavoritesState> emit,
  ) {
    emit(state.copyWith(status: FavoritesStatus.disabled));
  }

  void _onAddFavoritesItem(
    AddFavoritesItem event,
    Emitter<FavoritesState> emit,
  ) {
    // _userBloc.add(SubscribeTopic(topic: event.event.uid));
    emit(state.addItem(event.event));
  }

  void _onRemoveFavoritesItem(
    RemoveFavoritesItem event,
    Emitter<FavoritesState> emit,
  ) {
    // _userBloc.add(UnsubscribeTopic(topic: event.event.uid));
    emit(state.removeItem(event.event));
  }

  @override
  FavoritesState fromJson(Map<String, dynamic> json) =>
      FavoritesState.fromJson(json);

  @override
  Map<String, dynamic> toJson(FavoritesState state) => state.toJson();
}
