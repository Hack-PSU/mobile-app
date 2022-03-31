
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackpsu/models/email.dart';
import 'package:hackpsu/models/password.dart';

import '../data/authentication_repository.dart';
import '../models/email.dart';
import '../models/password.dart';
import '../models/profile_model.dart';


class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit(
  this._authenticationRepository,
  ) : super(const ProfileState());

  final AuthenticationRepository _authenticationRepository;

  

  void emailChanged(String newEmail) {
    final email = Email.dirty(newEmail);

    emit(
      state.copyWith(
        email: email,
      ),
    );
  }


  void passwordChanged(String newPassword) {
    final password = Password.dirty(newPassword);
    emit(
      state.copyWith(
        password: password,
        // status: Formz.validate([state.email, password]),
      ),
    );
  }

  void changePassword(String currentPassword, String newPassword) async {
  final user = await FirebaseAuth.instance.currentUser;
  final cred = EmailAuthProvider.credential(
      email: user.email, password: "asdfghjkl");
  user.reauthenticateWithCredential(cred).then((value) {
    user.updatePassword(newPassword).then((_) {
      //Success, do something
    }).catchError((error) {
      print("error");
    });
  }).catchError((err) {
    print(err);
  
  });}
}
