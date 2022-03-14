import 'package:bloc/bloc.dart';

class HeaderCubit extends Cubit<bool> {
  HeaderCubit() : super(false);

  void toggleSwitch(bool newValue) => emit(newValue);
}
