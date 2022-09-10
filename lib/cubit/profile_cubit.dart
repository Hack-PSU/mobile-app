import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../common/services/authentication_repository.dart';
import '../models/password.dart';
import '../models/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._authenticationRepository,
  )   : _firebaseAuth = FirebaseAuth.instance,
        super(
          ProfileState.initialize(),
        );

  final AuthenticationRepository _authenticationRepository;
  final FirebaseAuth _firebaseAuth;

  void oldPasswordChanged(String newValue) {
    final password = Password.dirty(newValue);
    emit(
      state.copyWith(
        oldPassword: password,
      ),
    );
  }

  void newPasswordChanged(String newValue) {
    final password = Password.dirty(newValue);
    emit(
      state.copyWith(
        newPassword: password,
      ),
    );
  }

  Future<void> changePassword() async {
    final user = _firebaseAuth.currentUser!;

    final AuthCredential credential = EmailAuthProvider.credential(
      email: state.email!,
      password: state.oldPassword!.value,
    );

    try {
      await user.reauthenticateWithCredential(credential);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Unable to reauthenticate");
    }

    try {
      await user.updatePassword(state.newPassword!.value);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Unable to change password");
    }
  }
}
