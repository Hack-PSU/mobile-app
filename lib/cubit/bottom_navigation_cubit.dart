import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/bloc/navigation/bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<Routes> {
  BottomNavigationCubit() : super(Routes.Home);
  void navigate(Routes index) => emit(index);
}
