import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../data/user_repository.dart';
import '../models/registration.dart';

class RegistrationCubit extends Cubit<List<Registration>> {
  RegistrationCubit(
    UserRepository userRepository,
  )   : _userRepository = userRepository,
        super(null);

  final UserRepository _userRepository;

  Future<void> getUserInfo() async {
    try {
      final users = await _userRepository.getUserInfo();
      emit(users);
    } catch (e) {
      debugPrint(e.toString());
    }
    // emit(users);
  }
}
