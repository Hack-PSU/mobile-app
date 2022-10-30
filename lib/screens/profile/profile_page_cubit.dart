import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/api/user.dart';
import '../../common/models/password.dart';
import '../../common/services/authentication_repository.dart';

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
        String firstInitial = "";
        String lastInitial = "";

        if (names.first.isNotEmpty) {
          firstInitial = names.first[0];
        }

        if (names.last != names.first && names.last.isNotEmpty) {
          lastInitial = names.last[0];
        }

        return "$firstInitial$lastInitial".toUpperCase().trim();
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
  ProfilePageCubit(
    AuthenticationRepository authenticationRepository,
    UserRepository userRepository,
  )   : _firebaseAuth = FirebaseAuth.instance,
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(
          ProfilePageCubitState.init(),
        );

  final FirebaseAuth _firebaseAuth;
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

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

  Future<void> revokeUser() async {
    if (FirebaseAuth.instance.currentUser?.uid ==
            "gsOwfFcUHKfmRHTsmI7N1k7Ocie2" ||
        FirebaseAuth.instance.currentUser?.uid ==
            "FHBbkIw88qZBaxSmQxmdtSURsto1") {
      throw Exception("Cannot delete admin user");
    }

    if (await const FlutterSecureStorage().read(key: "refresh_token") != null) {
      await _authenticationRepository.revokeAppleUser();
    }
    await _userRepository.deleteUser();
    await _authenticationRepository.signOut();
  }
}
