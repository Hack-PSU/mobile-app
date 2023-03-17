// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_credit_class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraCreditClass _$ExtraCreditClassFromJson(Map<String, dynamic> json) =>
    ExtraCreditClass(
      id: json['id'] as int,
      name: json['name'] as String,
      hackathonId: json['hackathon_id'] as String,
    );

Map<String, dynamic> _$ExtraCreditClassToJson(ExtraCreditClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hackathon_id': instance.hackathonId,
    };
