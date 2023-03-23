// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registration _$RegistrationFromJson(Map<String, dynamic> json) => Registration(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
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
      hackathonId: json['hackathonId'] as String?,
      time: Registration._timeFromJson(json['time'] as int),
    );

Map<String, dynamic> _$RegistrationToJson(Registration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
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
      'time': Registration._timeToJson(instance.time),
      'hackathonId': instance.hackathonId,
    };
