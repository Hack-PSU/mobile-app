import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../common/api/user.dart';
import '../../common/api/user/user_body_model.dart';
import '../../common/bloc/user/user_bloc.dart';
import '../../common/bloc/user/user_event.dart';

class CreateProfileCubitState extends Equatable {
  const CreateProfileCubitState._({
    this.firstName,
    this.lastName,
    this.gender,
    this.shirtSize,
    this.dietaryRestriction,
    this.allergies,
    this.university,
    this.email,
    this.major,
    this.phone,
    this.country,
    this.race,
    this.isSubmitting,
  });

  const CreateProfileCubitState.init() : this._();

  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? shirtSize;
  final String? dietaryRestriction;
  final String? allergies;
  final String? university;
  final String? email;
  final String? major;
  final String? phone;
  final String? country;
  final String? race;
  final bool? isSubmitting;

  CreateProfileCubitState copyWith({
    String? firstName,
    String? lastName,
    String? gender,
    String? shirtSize,
    String? dietaryRestriction,
    String? allergies,
    String? university,
    String? email,
    String? major,
    String? phone,
    String? country,
    String? race,
    bool? isSubmitting,
  }) {
    return CreateProfileCubitState._(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      shirtSize: shirtSize ?? this.shirtSize,
      dietaryRestriction: dietaryRestriction ?? this.dietaryRestriction,
      allergies: allergies ?? this.allergies,
      university: university ?? this.university,
      email: email ?? this.email,
      major: major ?? this.major,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      race: race ?? this.race,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        gender,
        shirtSize,
        dietaryRestriction,
        allergies,
        university,
        email,
        major,
        phone,
        country,
        race,
        isSubmitting,
      ];
}

class CreateProfileCubit extends Cubit<CreateProfileCubitState> {
  CreateProfileCubit({
    required UserBloc userBloc,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        _userBloc = userBloc,
        _firebaseAuth = FirebaseAuth.instance,
        super(const CreateProfileCubitState.init());

  final UserRepository _userRepository;
  final FirebaseAuth _firebaseAuth;
  final UserBloc _userBloc;

  void copyWith({
    String? firstName,
    String? lastName,
    String? gender,
    String? shirtSize,
    String? dietaryRestriction,
    String? allergies,
    String? university,
    String? email,
    String? major,
    String? phone,
    String? country,
    String? race,
    bool? isSubmitting,
  }) {
    emit(
      state.copyWith(
        firstName: firstName ?? state.firstName,
        lastName: lastName ?? state.lastName,
        gender: gender ?? state.gender,
        shirtSize: shirtSize ?? state.shirtSize,
        dietaryRestriction: dietaryRestriction ?? state.dietaryRestriction,
        allergies: allergies ?? state.allergies,
        university: university ?? state.university,
        email: email ?? state.email,
        major: major ?? state.major,
        phone: phone ?? state.phone,
        country: country ?? state.country,
        race: race ?? state.race,
        isSubmitting: isSubmitting ?? state.isSubmitting,
      ),
    );
  }

  void goToMain() {
    _userBloc.add(const RegisterUser());
  }

  Future<void> submit() async {
    emit(state.copyWith(isSubmitting: true));

    final user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        final newUser = UserBody(
          id: user.uid,
          country: state.country,
          email: state.email,
          firstName: state.firstName,
          gender: state.gender,
          lastName: state.lastName,
          major: state.major ?? "",
          phone: state.phone,
          race: state.race,
          shirtSize: state.shirtSize,
          university: state.university ?? "",
          allergies: state.allergies ?? "",
          dietaryRestriction: state.dietaryRestriction ?? "",
        );

        await _userRepository.createUserProfile(newUser);
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
    emit(state.copyWith(isSubmitting: false));
  }
}
