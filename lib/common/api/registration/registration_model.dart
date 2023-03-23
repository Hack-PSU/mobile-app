import 'package:json_annotation/json_annotation.dart';

part 'registration_model.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: true,
)
class Registration {
  Registration({
    required this.id,
    required this.userId,
    required this.travelReimbursement,
    required this.driving,
    required this.firstHackathon,
    required this.educationalInstitutionType,
    required this.academicYear,
    this.codingExperience,
    required this.eighteenBeforeEvent,
    required this.mlhCoc,
    required this.mlhDcp,
    this.referral,
    this.project,
    this.expectations,
    required this.shareAddressMlh,
    required this.shareAddressSponsors,
    required this.shareEmailMlh,
    required this.veteran,
    required this.hackathonId,
    required this.time,
  });

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationToJson(this);

  static DateTime _timeFromJson(int date) =>
      DateTime.fromMillisecondsSinceEpoch(date);

  static int _timeToJson(DateTime date) => date.millisecondsSinceEpoch;

  final int? id;
  final String? userId;
  final bool? eighteenBeforeEvent;
  final bool? travelReimbursement;
  final bool? driving;
  final bool? firstHackathon;
  final String? academicYear;
  final String? educationalInstitutionType;
  final bool? mlhCoc;
  final bool? mlhDcp;
  final String? codingExperience;
  final String? referral;
  final String? project;
  final String? expectations;
  final String? veteran;
  final bool? shareAddressMlh;
  final bool? shareAddressSponsors;
  final bool? shareEmailMlh;
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime time;
  final String? hackathonId;
}
