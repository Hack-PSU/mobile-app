import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Registration {
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
  final DateTime time;
  final String hackathon;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final int basePin;
  final bool active;

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

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
        uid: json['uid'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        gender: json['gender'],
        eighteenBeforeEvent: json['eighteenBeforeEvent'],
        shirtSize: json['shirt_size'],
        dietaryRestriction: json['dietary_restriction'],
        allergies: json['allergies'],
        travelReimbursement: json['travel_reimbursement'],
        firstHackathon: json['first_hackathon'],
        university: json['university'],
        email: json['email'],
        academicYear: json['academic_year'],
        major: json['major'],
        resume: json['resume'],
        mlhCoc: json['mlh_coc'],
        mlhDcp: json['mlh_dcp'],
        phone: json['phone'],
        address: json['address'],
        race: json['race'],
        codingExperience: json['coding_experience'],
        referral: json['referral'],
        project: json['project'],
        submitted: json['submitted'],
        expectations: json['expectations'],
        veteran: json['veteran'],
        pin: json['pin'],
        shareAddressMlh: json['share_address_mlh'],
        shareAddressSponsors: json['share_address_sponsors'],
        time: DateTime.fromMillisecondsSinceEpoch(int.parse(json['time'])),
        hackathon: json['hackathon'],
        name: json['name'],
        startTime:
            DateTime.fromMillisecondsSinceEpoch(int.parse(json['start_time'])),
        endTime:
            DateTime.fromMillisecondsSinceEpoch(int.parse(json['end_time'])),
        basePin: json['base_pin'],
        active: json['active']);
  }
}
