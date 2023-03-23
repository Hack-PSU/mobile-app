import 'package:json_annotation/json_annotation.dart';

part 'registration_body_model.g.dart';

@JsonSerializable(
  createToJson: true,
)
class RegistrationBody {
  RegistrationBody({
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
    required this.time,
  });

  Map<String, dynamic> toJson() => _$RegistrationBodyToJson(this);

  static int _timeToJson(DateTime date) => date.millisecondsSinceEpoch;

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
  @JsonKey(toJson: _timeToJson)
  final DateTime time;
}
