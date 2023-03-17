// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: $enumDecodeNullable(_$EventTypeEnumMap, json['type']),
      startTime: Event._eventTimeFromJson(json['startTime'] as int),
      endTime: Event._eventTimeFromJson(json['endTime'] as int),
      description: json['description'] as String?,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      icon: json['icon'] as String?,
      wsPresenterNames: json['wsPresenterNames'] as String?,
      wsRelevantSkills: json['wsRelevantSkills'] as String?,
      wsSkillLevel: json['wsSkillLevel'] as String?,
      wsUrls:
          (json['wsUrls'] as List<dynamic>?)?.map((e) => e as String).toList(),
      starred: json['starred'] as bool? ?? false,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$EventTypeEnumMap[instance.type],
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'description': instance.description,
      'location': instance.location,
      'starred': instance.starred,
      'icon': instance.icon,
      'wsPresenterNames': instance.wsPresenterNames,
      'wsUrls': instance.wsUrls,
      'wsSkillLevel': instance.wsSkillLevel,
      'wsRelevantSkills': instance.wsRelevantSkills,
    };

const _$EventTypeEnumMap = {
  EventType.ACTIVITY: 'activity',
  EventType.WORKSHOP: 'workshop',
  EventType.FOOD: 'food',
  EventType.CHECKIN: 'checkIn',
};
