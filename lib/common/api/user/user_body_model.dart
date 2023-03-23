import 'package:json_annotation/json_annotation.dart';

part 'user_body_model.g.dart';

@JsonSerializable(
  createToJson: true,
)
class UserBody {
  UserBody({
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
    required this.phone,
    required this.country,
    required this.race,
  });

  Map<String, dynamic> toJson() => _$UserBodyToJson(this);

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
  final String? phone;
  final String? country;
  final String? race;
}
