import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registration.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Registration {
  Registration({
    @required this.uid,
    @required this.firstname,
    @required this.lastname,
    @required this.gender,
    @required this.eighteenBeforeEvent,
    @required this.shirtSize,
    this.dietaryRestriction,
    this.allergies,
    @required this.travelReimbursement,
    @required this.firstHackathon,
    @required this.university,
    @required this.email,
    @required this.academicYear,
    @required this.major,
    this.resume,
    @required this.mlhCoc,
    @required this.mlhDcp,
    @required this.phone,
    @required this.address,
    @required this.race,
    @required this.codingExperience,
    this.referral,
    this.project,
    @required this.submitted,
    this.expectations,
    @required this.veteran,
    @required this.pin,
    @required this.shareAddressMlh,
    @required this.shareAddressSponsors,
    @required this.time,
    @required this.hackathon,
    @required this.name,
    @required this.startTime,
    @required this.endTime,
    @required this.basePin,
    @required this.active,
  });

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationToJson(this);

  static DateTime _timeFromJson(String date) =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(date));

  final String uid;
  final String firstname;
  final String lastname;
  final String gender;
  final bool eighteenBeforeEvent;
  final String shirtSize;
  final String dietaryRestriction;
  final String allergies;
  final bool travelReimbursement;
  final bool firstHackathon;
  final String university;
  final String email;
  final String academicYear;
  final String major;
  final dynamic resume;
  final bool mlhCoc;
  final bool mlhDcp;
  final String phone;
  final String address;
  final String race;
  final String codingExperience;
  final String referral;
  final String project;
  final bool submitted;
  final String expectations;
  final String veteran;
  final int pin;
  final bool shareAddressMlh;
  final bool shareAddressSponsors;
  @JsonKey(fromJson: _timeFromJson)
  final DateTime time;
  final String hackathon;
  final String name;
  @JsonKey(fromJson: _timeFromJson)
  final DateTime startTime;
  @JsonKey(fromJson: _timeFromJson)
  final DateTime endTime;
  final int basePin;
  final bool active;
}
