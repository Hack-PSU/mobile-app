// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_credit_assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraCreditAssignment _$ExtraCreditAssignmentFromJson(
        Map<String, dynamic> json) =>
    ExtraCreditAssignment(
      id: json['id'] as int,
      userId: json['userId'] as String,
      classId: json['classId'] as int,
      hackathonId: json['hackathonId'] as String,
    );

Map<String, dynamic> _$ExtraCreditAssignmentToJson(
        ExtraCreditAssignment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'classId': instance.classId,
      'hackathonId': instance.hackathonId,
    };
