import 'package:equatable/equatable.dart';

import '../../models/event.dart';

class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class EnableFavorites extends FavoritesEvent {}

class DisableFavorites extends FavoritesEvent {}

class AddFavoritesItem extends FavoritesEvent {
  const AddFavoritesItem(this.event);

  final Event event;

  @override
  List<Object> get props => [event];
}

class RemoveFavoritesItem extends FavoritesEvent {
  const RemoveFavoritesItem(this.event);

  final Event event;

  @override
  List<Object> get props => [event];
}
