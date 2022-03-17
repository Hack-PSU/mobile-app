import 'package:equatable/equatable.dart';

class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesEnabled extends FavoritesEvent {}

class FavoritesDisabled extends FavoritesEvent {}

class AddFavoritesItem extends FavoritesEvent {
  const AddFavoritesItem({
    this.id,
  });

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
