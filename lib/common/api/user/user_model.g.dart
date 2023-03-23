// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      gender: json['gender'] as String?,
      shirtSize: json['shirtSize'] as String?,
      dietaryRestriction: json['dietaryRestriction'] as String?,
      allergies: json['allergies'] as String?,
      university: json['university'] as String?,
      email: json['email'] as String?,
      major: json['major'] as String?,
      resume: json['resume'] as String?,
      phone: json['phone'] as String?,
      country: json['country'] as String?,
      race: json['race'] as String?,
      registration: json['registration'] == null
          ? null
          : Registration.fromJson(json['registration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'shirtSize': instance.shirtSize,
      'dietaryRestriction': instance.dietaryRestriction,
      'allergies': instance.allergies,
      'university': instance.university,
      'email': instance.email,
      'major': instance.major,
      'resume': instance.resume,
      'phone': instance.phone,
      'country': instance.country,
      'race': instance.race,
      'registration': instance.registration,
    };
