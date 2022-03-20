import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/event.dart';

class FavoritesCubit extends HydratedCubit<List<String>> {
  FavoritesCubit() : super([]);

  void addFavorite(Event event) {
    final newList = List.of(state);
    newList.add(event.uid);
    emit(newList);
  }

  bool getFavorite(Event event) {
    return state.contains(event.uid);
  }

  @override
  List<String> fromJson(Map<String, dynamic> json) {
    return json["value"] as List<String>;
  }

  @override
  Map<String, dynamic> toJson(List<String> state) {
    return {"value": state};
  }
}
