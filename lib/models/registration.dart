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
/*
{
    "api_response": "Success",
    "status": 200,
    "body": {
        "result": "Success",
        "data": [
            {
                "uid": "seeo04gp3qZYrrY5gWN30NmzDHe2",
                "firstname": "Raied", **
                "lastname": "Rod", **
                "gender": "male",  **
                "eighteenBeforeEvent": true, **
                "shirt_size": "M", **
                "dietary_restriction": null, **
                "allergies": null, **
                "travel_reimbursement": false, **
                "first_hackathon": false, **
                "university": "The University of Pittsburgh", **
                "email": "raied@email.com", **
                "academic_year": "sophomore", **
                "major": "Computer Science", **
                "resume": null, **
                "mlh_coc": true, **
                "mlh_dcp": true, **
                "phone": "5555555555",
                "address": "eecececeec, ceceea, asdf, aaaa, 22423",
                "race": "asian", **
                "coding_experience": "none", **
                "referral": null, **
                "project": null, **
                "submitted": true, **
                "expectations": null, **
                "veteran": "false", **
                "pin": 10057,
                "share_address_mlh": false,
                "share_address_sponsors": false,
                "time": "1604008390544",
                "hackathon": "80ae630f6b3241fbbc8f427c94d3aaf7", **
                "name": "Test 1234567",
                "start_time": "1572408000000",
                "end_time": "1604441068310",
                "base_pin": 10008,
                "active": false
            },
            {
                "uid": "seeo04gp3qZYrrY5gWN30NmzDHe2",
                "firstname": "raied",
                "lastname": "raied",
                "gender": "non-binary",
                "eighteenBeforeEvent": true,
                "shirt_size": "XXL",
                "dietary_restriction": null,
                "allergies": null,
                "travel_reimbursement": false,
                "first_hackathon": false,
                "university": "21st Century Cyber Charter School",
                "email": "raied@email.com",
                "academic_year": "freshman",
                "major": "Plant Science And Agronomy",
                "resume": null,
                "mlh_coc": true,
                "mlh_dcp": true,
                "phone": "5555555555",
                "address": null,
                "race": "asian",
                "coding_experience": "none",
                "referral": null,
                "project": null,
                "submitted": true,
                "expectations": null,
                "veteran": "false",
                "pin": 10084,
                "share_address_mlh": false,
                "share_address_sponsors": false,
                "time": "1614695182229",
                "hackathon": "81069f2a04cb465994ad84155af6e868",
                "name": "S2021",
                "start_time": "1611245843000",
                "end_time": "1621613843000",
                "base_pin": 10074,
                "active": true
            }
        ]
    }
}
*/