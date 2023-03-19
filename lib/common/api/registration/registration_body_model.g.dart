// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationBody _$RegistrationBodyFromJson(Map<String, dynamic> json) =>
    RegistrationBody(
      travelReimbursement: json['travelReimbursement'] as bool?,
      driving: json['driving'] as bool?,
      firstHackathon: json['firstHackathon'] as bool?,
      educationalInstitutionType: json['educationalInstitutionType'] as String?,
      academicYear: json['academicYear'] as String?,
      codingExperience: json['codingExperience'] as String?,
      eighteenBeforeEvent: json['eighteenBeforeEvent'] as bool?,
      mlhCoc: json['mlhCoc'] as bool?,
      mlhDcp: json['mlhDcp'] as bool?,
      referral: json['referral'] as String?,
      project: json['project'] as String?,
      expectations: json['expectations'] as String?,
      shareAddressMlh: json['shareAddressMlh'] as bool?,
      shareAddressSponsors: json['shareAddressSponsors'] as bool?,
      shareEmailMlh: json['shareEmailMlh'] as bool?,
      veteran: json['veteran'] as String?,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$RegistrationBodyToJson(RegistrationBody instance) =>
    <String, dynamic>{
      'eighteenBeforeEvent': instance.eighteenBeforeEvent,
      'travelReimbursement': instance.travelReimbursement,
      'driving': instance.driving,
      'firstHackathon': instance.firstHackathon,
      'academicYear': instance.academicYear,
      'educationalInstitutionType': instance.educationalInstitutionType,
      'mlhCoc': instance.mlhCoc,
      'mlhDcp': instance.mlhDcp,
      'codingExperience': instance.codingExperience,
      'referral': instance.referral,
      'project': instance.project,
      'expectations': instance.expectations,
      'veteran': instance.veteran,
      'shareAddressMlh': instance.shareAddressMlh,
      'shareAddressSponsors': instance.shareAddressSponsors,
      'shareEmailMlh': instance.shareEmailMlh,
      'time': RegistrationBody._timeToJson(instance.time),
    };
