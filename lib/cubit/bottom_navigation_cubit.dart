import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_navigation.dart';

class BottomNavigationCubit extends Cubit<Routes> {
  BottomNavigationCubit() : super(Routes.Home);
  void navigate(Routes index) => emit(index);
}
