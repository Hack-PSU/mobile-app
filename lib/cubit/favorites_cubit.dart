import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/event.dart';

class FavoritesCubit extends HydratedCubit<Set<String?>> {
  FavoritesCubit() : super(<String>{});

  void addFavorite(Event event) {
    final newFavorites = Set.of(state);
    newFavorites.add(event.uid);
    emit(newFavorites);
  }

  bool getFavorite(Event event) {
    return state.contains(event.uid);
  }

  @override
  Set<String> fromJson(Map<String, dynamic> json) {
    final favorites = json["favorites"] as List<String>;
    return favorites.toSet();
  }

  @override
  Map<String, dynamic> toJson(Set<String?> state) {
    return <String, List<String?>>{"favorites": state.toList()};
  }
}
