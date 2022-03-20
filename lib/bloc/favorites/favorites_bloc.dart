import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../models/event.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends HydratedBloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(List<Event> items)
      : super(
          FavoritesState.initialize(items),
        ) {
    on<AddFavoritesItem>(_onAddFavoritesItem);
    on<AddMoreFavorites>(_onAddMoreFavorites);
  }

  void _onAddFavoritesItem(
      AddFavoritesItem event, Emitter<FavoritesState> emit) {
    state.add(event.id);
    debugPrint(event.id);
    emit(
      FavoritesState.update(state.events, state.items),
    );
  }

  void _onAddMoreFavorites(
      AddMoreFavorites event, Emitter<FavoritesState> emit) {
    state.addMore(event.items);
    debugPrint(state.items.toString());
    emit(
      FavoritesState.update(state.events, state.items),
    );
  }

  @override
  FavoritesState fromJson(Map<String, dynamic> json) {
    final favorites = json["favorites"] as Map<String, Map<String, dynamic>>;
    final items = {};
    List<Event> events;

    for (final String key in favorites.keys) {
      items[key] = FavoritesItem.fromJson(favorites[key]);
      events.add((items[key] as FavoritesItem).data);
    }
    return FavoritesState.update(events, items as Map<String, FavoritesItem>);
  }

  @override
  Map<String, dynamic> toJson(FavoritesState state) {
    return {
      "favorites": Map.fromIterables(
          state.items.keys,
          state.items.keys.map(
            (key) => state.items[key].toJson(),
          )),
    };
  }
}
