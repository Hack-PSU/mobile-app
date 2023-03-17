// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registration _$RegistrationFromJson(Map<String, dynamic> json) => Registration(
      id: json['id'] as String?,
      eighteenBeforeEvent: json['eighteenBeforeEvent'] as bool?,
      travelReimbursement: json['travelReimbursement'] as bool?,
      firstHackathon: json['firstHackathon'] as bool?,
      academicYear: json['academicYear'] as String?,
      mlhCoc: json['mlhCoc'] as bool?,
      mlhDcp: json['mlhDcp'] as bool?,
      codingExperience: json['codingExperience'] as String?,
      referral: json['referral'] as String?,
      project: json['project'] as String?,
      expectations: json['expectations'] as String?,
      veteran: json['veteran'] as String?,
      shareAddressMlh: json['shareAddressMlh'] as bool?,
      shareAddressSponsors: json['shareAddressSponsors'] as bool?,
      time: Registration._timeFromJson(json['time'] as int),
      hackathonId: json['hackathonId'] as String?,
    );

Map<String, dynamic> _$RegistrationToJson(Registration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eighteenBeforeEvent': instance.eighteenBeforeEvent,
      'travelReimbursement': instance.travelReimbursement,
      'firstHackathon': instance.firstHackathon,
      'academicYear': instance.academicYear,
      'mlhCoc': instance.mlhCoc,
      'mlhDcp': instance.mlhDcp,
      'codingExperience': instance.codingExperience,
      'referral': instance.referral,
      'project': instance.project,
      'expectations': instance.expectations,
      'veteran': instance.veteran,
      'shareAddressMlh': instance.shareAddressMlh,
      'shareAddressSponsors': instance.shareAddressSponsors,
      'time': Registration._timeToJson(instance.time),
      'hackathonId': instance.hackathonId,
    };
