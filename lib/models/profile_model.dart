import 'package:formz/formz.dart';
import 'base_model.dart';
import 'email.dart';
import 'password.dart';

class ProfileState extends BaseModel {
  const ProfileState({
    this.email,
    this.password,
    this.profileImage,
  });

  final Email email;
  final Password password;
  final String profileImage;


  @override
  List<Object> get props => [email, password, profileImage];

  String getEmail() {
    email != null ? email.value : "qb1199299@gmail.com";
    return "qb1199299@gmail.com";

  }

  String getName() {
    return "Quinn B";
  }


    String getPin() {
    return "12345";
  }

  
  ProfileState copyWith({
    Email email,
    Password password,
    String profileImage,

  }) {
    return ProfileState(
      email: email ?? this.email,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage

    );
  }

  @override
  bool isReady() {
    return true;
  }
}
