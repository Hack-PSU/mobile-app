import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc<M> extends HydratedBloc<FavoritesEvent, FavoritesState<M>> {
  FavoritesBloc(List<M> items)
      : super(
          FavoritesState.initialize(items),
        ) {
    on<AddFavoritesItem>(_onAddFavoritesItem);
  }

  void _onAddFavoritesItem(
      AddFavoritesItem event, Emitter<FavoritesState<M>> emit) {
    state.add(event.id);
    emit(
      FavoritesState.update(state.items),
    );
  }

  @override
  FavoritesState<M> fromJson(Map<String, dynamic> json) =>
      FavoritesState.update(
        json["favorites"] as Map<String, FavoritesItem<M>>,
      );

  @override
  Map<String, dynamic> toJson(FavoritesState<M> state) =>
      {"favorites": state.items};
}
