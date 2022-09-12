import 'package:bloc/bloc.dart';

import '../../common/bloc/favorites/favorites_bloc.dart';
import '../../common/bloc/favorites/favorites_event.dart';

class ScreenHeaderCubit extends Cubit<bool> {
  ScreenHeaderCubit(
    FavoritesBloc favoritesBloc,
  )   : _favoritesBloc = favoritesBloc,
        super(false);

  final FavoritesBloc _favoritesBloc;

  void toggleSwitch(bool newValue) {
    emit(newValue);
    _favoritesBloc.add(
      newValue == true ? EnableFavorites() : DisableFavorites(),
    );
  }
}
