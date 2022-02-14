import 'package:bloc/bloc.dart';
import 'package:hackpsu/data/user_repository.dart';
import 'package:hackpsu/models/registration.dart';

class RegistrationCubit extends Cubit<List<Registration>> {
  RegistrationCubit(
    UserRepository userRepository,
  )   : _userRepository = userRepository,
        super(null);

  final UserRepository _userRepository;

  Future<void> getUserInfo() async {
    final users = await _userRepository.getUserInfo();
    emit(users);
  }
}
