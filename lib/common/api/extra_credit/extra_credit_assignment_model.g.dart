// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_credit_assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraCreditAssignment _$ExtraCreditAssignmentFromJson(
        Map<String, dynamic> json) =>
    ExtraCreditAssignment(
      uid: json['uid'] as int,
      userUid: json['user_uid'] as String,
      classUid: json['class_uid'] as int,
      hackathon: json['hackathon'] as String,
    );

Map<String, dynamic> _$ExtraCreditAssignmentToJson(
        ExtraCreditAssignment instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'user_uid': instance.userUid,
      'class_uid': instance.classUid,
      'hackathon': instance.hackathon,
    };
