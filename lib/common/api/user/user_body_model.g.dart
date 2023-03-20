// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBody _$UserBodyFromJson(Map<String, dynamic> json) => UserBody(
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
      phone: json['phone'] as String?,
      country: json['country'] as String?,
      race: json['race'] as String?,
    );

Map<String, dynamic> _$UserBodyToJson(UserBody instance) => <String, dynamic>{
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
      'phone': instance.phone,
      'country': instance.country,
      'race': instance.race,
    };
