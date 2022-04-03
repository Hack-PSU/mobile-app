import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'base_model.dart';
import 'email.dart';
import 'password.dart';

class ProfileState extends BaseModel {
  ProfileState._({
    this.oldPassword,
    this.newPassword,
  }) : _firebaseAuth = FirebaseAuth.instance;

  ProfileState.initialize()
      : this._(
          oldPassword: Password.pure(),
          newPassword: Password.pure(),
        );

  final FirebaseAuth _firebaseAuth;
  final Password oldPassword;
  final Password newPassword;

  String get email => _firebaseAuth.currentUser.email;

  String get name => _firebaseAuth.currentUser.displayName;

  String get initials {
    final user = _firebaseAuth.currentUser.displayName;
    final names = user.split(" ");

    if (names.length > 1) {
      return "${names.first[0]}${names.last[0]}";
    } else {
      return names.first[0];
    }
  }

  @override
  List<Object> get props => [oldPassword, newPassword];
  //
  // String getEmail() {
  //   _firebaseAuth.currentUser.email
  //   email != null ? email.value : "qb1199299@gmail.com";
  //   return "qb1199299@gmail.com";
  // }

  // String getName() {
  //   return "Quinn B";
  // }

  String getPin() {
    return "12345";
  }

  ProfileState copyWith({
    Password oldPassword,
    Password newPassword,
  }) {
    return ProfileState._(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  @override
  bool isReady() {
    return true;
  }
}
