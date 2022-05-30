// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      uid: json['uid'] as String?,
      eventTitle: json['event_title'] as String?,
      eventType: $enumDecodeNullable(_$EventTypeEnumMap, json['event_type']),
      eventStartTime: Event._eventTimeFromJson(json['event_start_time'] as int),
      eventEndTime: Event._eventTimeFromJson(json['event_end_time'] as int),
      eventDescription: json['event_description'] as String?,
      locationName: json['location_name'] as String?,
      starred: json['starred'] as bool? ?? false,
      eventIcon: json['event_icon'] as String?,
      wsPresenterNames: json['ws_presenter_names'] as String?,
      wsUrls:
          (json['ws_urls'] as List<dynamic>?)?.map((e) => e as String).toList(),
      wsRelevantSkills: json['ws_relevant_skills'] as String?,
      wsSkillLevel: json['ws_skill_level'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'uid': instance.uid,
      'event_title': instance.eventTitle,
      'event_type': _$EventTypeEnumMap[instance.eventType],
      'event_start_time': instance.eventStartTime.toIso8601String(),
      'event_end_time': instance.eventEndTime.toIso8601String(),
      'event_description': instance.eventDescription,
      'location_name': instance.locationName,
      'starred': instance.starred,
      'event_icon': instance.eventIcon,
      'ws_presenter_names': instance.wsPresenterNames,
      'ws_urls': instance.wsUrls,
      'ws_skill_level': instance.wsSkillLevel,
      'ws_relevant_skills': instance.wsRelevantSkills,
    };

const _$EventTypeEnumMap = {
  EventType.ACTIVITY: 'activity',
  EventType.WORKSHOP: 'workshop',
  EventType.FOOD: 'food',
};
