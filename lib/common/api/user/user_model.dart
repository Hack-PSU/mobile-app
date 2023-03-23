import 'package:json_annotation/json_annotation.dart';

import '../registration/registration_model.dart';

part 'user_model.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: true,
)
class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.shirtSize,
    this.dietaryRestriction,
    this.allergies,
    required this.university,
    required this.email,
    required this.major,
    this.resume,
    required this.phone,
    required this.country,
    required this.race,
    this.registration,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? shirtSize;
  final String? dietaryRestriction;
  final String? allergies;
  final String? university;
  final String? email;
  final String? major;
  final String? resume;
  final String? phone;
  final String? country;
  final String? race;
  final Registration? registration;
}
