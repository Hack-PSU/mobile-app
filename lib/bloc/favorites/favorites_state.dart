import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';

import '../../models/event.dart';

enum FavoritesStatus { enabled, disabled }

class FavoritesItem {
  FavoritesItem({
    @required this.isFavorite,
    @required this.data,
  });

  final Event data;
  // final String id;
  bool isFavorite = false;

  bool getIsFavorite() => isFavorite;

  Map<String, dynamic> toJson() =>
      {"isFavorite": isFavorite, "data": data.toJson()};

  @override
  String toString() {
    return "uid: ${data.uid}, isFavorite: $isFavorite";
  }

  static FavoritesItem fromJson(Map<String, dynamic> json) => FavoritesItem(
      isFavorite: json["isFavorite"] as bool,
      data: Event.fromJson(json["data"] as Map<String, dynamic>));
}

class FavoritesMap {
  static Map<String, FavoritesItem> createFavoritesMap(List<Event> items) {
    final favoritesMap = <String, FavoritesItem>{};
    for (final item in items) {
      favoritesMap[item.uid] = FavoritesItem(isFavorite: false, data: item);
    }
    return favoritesMap;
  }

  static void add(Map<String, FavoritesItem> items, String id) {
    items[id].isFavorite = true;
  }

  static void addMore(List<Event> events, Map<String, FavoritesItem> items,
      List<Event> newEvents) {
    events.addAll(newEvents);
    for (final Event event in newEvents) {
      if (!items.keys.contains(event.uid)) {
        items
            .addAll({event.uid: FavoritesItem(isFavorite: false, data: event)});
      }
    }
  }
}

class FavoritesState extends Equatable {
  const FavoritesState._({
    this.status,
    this.items,
    this.events,
    // this.favorites,
  });

  FavoritesState.initialize(List<Event> items)
      : this._(
          status: FavoritesStatus.disabled,
          items: FavoritesMap.createFavoritesMap(items),
          events: items,
        );

  const FavoritesState.enabled() : this._(status: FavoritesStatus.enabled);

  const FavoritesState.disabled() : this._(status: FavoritesStatus.disabled);

  const FavoritesState.update(
      List<Event> events, Map<String, FavoritesItem> items)
      : this._(items: items, events: events);

  void addMore(List<Event> newEvents) =>
      FavoritesMap.addMore(events, items, newEvents);

  void add(String id) => FavoritesMap.add(items, id);

  final FavoritesStatus status;
  final Map<String, FavoritesItem> items;
  final List<Event> events;

  @override
  List<Object> get props => [status];
}
