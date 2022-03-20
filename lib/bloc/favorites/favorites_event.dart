import 'package:equatable/equatable.dart';

import '../../models/event.dart';

class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesEnabled extends FavoritesEvent {}

class FavoritesDisabled extends FavoritesEvent {}

class AddMoreFavorites extends FavoritesEvent {
  const AddMoreFavorites(this.items);

  final List<Event> items;
}

class AddFavoritesItem extends FavoritesEvent {
  const AddFavoritesItem(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class RemoveFavoritesItem extends FavoritesEvent {
  const RemoveFavoritesItem({
    this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}
