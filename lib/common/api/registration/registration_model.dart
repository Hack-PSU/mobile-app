import 'package:json_annotation/json_annotation.dart';

part 'registration_model.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: true,
)
class Registration {
  Registration({
    required this.id,
    required this.eighteenBeforeEvent,
    required this.travelReimbursement,
    required this.firstHackathon,
    required this.academicYear,
    required this.mlhCoc,
    required this.mlhDcp,
    required this.codingExperience,
    this.referral,
    this.project,
    this.expectations,
    required this.veteran,
    required this.shareAddressMlh,
    required this.shareAddressSponsors,
    required this.time,
    required this.hackathonId,
  });

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationToJson(this);

  static DateTime _timeFromJson(int date) =>
      DateTime.fromMillisecondsSinceEpoch(date);

  static int _timeToJson(DateTime date) => date.millisecondsSinceEpoch;

  final String? id;
  final bool? eighteenBeforeEvent;
  final bool? travelReimbursement;
  final bool? firstHackathon;
  final String? academicYear;
  final bool? mlhCoc;
  final bool? mlhDcp;
  final String? codingExperience;
  final String? referral;
  final String? project;
  final String? expectations;
  final String? veteran;
  final bool? shareAddressMlh;
  final bool? shareAddressSponsors;
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime time;
  final String? hackathonId;
}
