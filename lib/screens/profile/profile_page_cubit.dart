import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../common/models/password.dart';

class ProfilePageCubitState extends Equatable {
  ProfilePageCubitState._({
    this.oldPassword,
    this.newPassword,
  }) : _firebaseAuth = FirebaseAuth.instance;

  ProfilePageCubitState.init()
      : this._(
          oldPassword: Password.pure(),
          newPassword: Password.pure(),
        );

  String? get email => _firebaseAuth.currentUser?.email;

  String? get name => _firebaseAuth.currentUser?.displayName;

  String? get initials {
    if (name != null) {
      final names = name?.split(" ");

      if (names != null) {
        if (names.length > 1) {
          return "${names.first[0]}${names.last[0]}";
        } else {
          return names.first[0];
        }
      }
    }
    return null;
  }

  ProfilePageCubitState copyWith({
    Password? oldPassword,
    Password? newPassword,
  }) {
    return ProfilePageCubitState._(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  final FirebaseAuth _firebaseAuth;
  final Password? oldPassword;
  final Password? newPassword;

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class ProfilePageCubit extends Cubit<ProfilePageCubitState> {
  ProfilePageCubit()
      : _firebaseAuth = FirebaseAuth.instance,
        super(
          ProfilePageCubitState.init(),
        );

  final FirebaseAuth _firebaseAuth;

  void onChangeOldPassword(String newValue) {
    emit(
      state.copyWith(oldPassword: Password.dirty(newValue)),
    );
  }

  void onChangeNewPassword(String newValue) {
    emit(
      state.copyWith(newPassword: Password.dirty(newValue)),
    );
  }

  Future<void> changePassword() async {
    final user = _firebaseAuth.currentUser;

    if (user != null &&
        state.email != null &&
        state.oldPassword != null &&
        state.oldPassword?.value != null &&
        state.newPassword?.value != null) {
      final AuthCredential credential = EmailAuthProvider.credential(
        email: state.email ?? "",
        password: state.oldPassword?.value ?? "",
      );

      try {
        await user.reauthenticateWithCredential(credential);
      } catch (e) {
        if (kDebugMode) {
          print(e);
          throw Exception("Unable to reauthenticate");
        }
      }

      try {
        await user.updatePassword(state.newPassword?.value ?? "");
      } catch (e) {
        if (kDebugMode) {
          print(e);
          throw Exception("Unable to change password");
        }
      }
    }
  }
}
