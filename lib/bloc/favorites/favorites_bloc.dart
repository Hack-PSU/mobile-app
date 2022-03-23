import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../models/event.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends HydratedBloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc()
      : super(
          FavoritesState.initialize(),
        ) {
    on<EnableFavorites>(_onEnableFavorites);
    on<DisableFavorites>(_onDisableFavorites);
    on<AddFavoritesItem>(_onAddFavoritesItem);
    on<RemoveFavoritesItem>(_onRemoveFavoritesItem);
  }

  void _onEnableFavorites(EnableFavorites event, Emitter<FavoritesState> emit) {
    emit(state.copyWith(status: FavoritesStatus.enabled));
  }

  void _onDisableFavorites(
      DisableFavorites event, Emitter<FavoritesState> emit) {
    emit(state.copyWith(status: FavoritesStatus.disabled));
  }

  void _onAddFavoritesItem(
      AddFavoritesItem event, Emitter<FavoritesState> emit) {
    emit(state.addItem(event.event));
  }

  void _onRemoveFavoritesItem(
      RemoveFavoritesItem event, Emitter<FavoritesState> emit) {
    emit(state.removeItem(event.event));
  }

  @override
  FavoritesState fromJson(Map<String, dynamic> json) =>
      FavoritesState.fromJson(json);

  @override
  Map<String, dynamic> toJson(FavoritesState state) => state.toJson();
}
