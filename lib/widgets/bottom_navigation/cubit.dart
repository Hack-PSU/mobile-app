import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/widgets/bottom_navigation/main.dart';

class BottomNavigationCubit extends Cubit<Routes> {
  BottomNavigationCubit() : super(Routes.Home);
  navigate(Routes index) => emit(index);
}
