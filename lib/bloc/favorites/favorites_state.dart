import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';

enum FavoritesStatus { enabled, disabled }

class FavoritesItem<M> {
  FavoritesItem({
    @required this.isFavorite,
    @required this.data,
  });

  final M data;
  // final String id;
  bool isFavorite;
}

class FavoritesMap<M> {
  static Map<String, FavoritesItem<M>> createFavoritesMap<M>(List<M> items) {
    final favoritesMap = <String, FavoritesItem<M>>{};
    for (final M item in items) {
      favoritesMap[nanoid(10)] =
          FavoritesItem<M>(isFavorite: false, data: item);
    }
    return favoritesMap;
  }

  static void add<M>(Map<String, FavoritesItem<M>> items, String id) {
    items[id].isFavorite = true;
  }
}

class FavoritesState<M> extends Equatable {
  const FavoritesState._({
    this.status,
    this.items,
    // this.favorites,
  });

  FavoritesState.initialize(List<M> items)
      : this._(
          status: FavoritesStatus.disabled,
          items: FavoritesMap.createFavoritesMap(items),
        );

  const FavoritesState.enabled() : this._(status: FavoritesStatus.enabled);

  const FavoritesState.disabled() : this._(status: FavoritesStatus.disabled);

  const FavoritesState.update(Map<String, FavoritesItem<M>> items)
      : this._(items: items);

  void add(String id) => FavoritesMap.add(items, id);

  final FavoritesStatus status;
  final Map<String, FavoritesItem<M>> items;

  @override
  List<Object> get props => [status];
}
