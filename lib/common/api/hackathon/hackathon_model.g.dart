// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hackathon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hackathon _$HackathonFromJson(Map<String, dynamic> json) => Hackathon(
      id: json['id'] as String,
      name: json['name'] as String,
      startTime: Hackathon._timeFromJson(json['startTime'] as int),
      endTime: Hackathon._timeFromJson(json['endTime'] as int),
      active: json['active'] as bool,
    );

Map<String, dynamic> _$HackathonToJson(Hackathon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'active': instance.active,
    };
