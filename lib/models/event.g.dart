// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    uid: json['uid'] as String,
    eventTitle: json['event_title'] as String,
    eventType: _$enumDecodeNullable(_$EventTypeEnumMap, json['event_type']),
    eventStartTime: Event._eventTimeFromJson(json['event_start_time'] as int),
    eventEndTime: Event._eventTimeFromJson(json['event_end_time'] as int),
    eventDescription: json['event_description'] as String,
    locationName: json['location_name'] as String,
    starred: json['starred'] as bool,
    eventIcon: json['event_icon'] as String,
    wsPresenterNames: json['ws_presenter_names'] as String,
    wsUrls: (json['ws_urls'] as List)?.map((e) => e as String)?.toList(),
    wsRelevantSkills: json['ws_relevant_skills'] as String,
    wsSkillLevel: json['ws_skill_level'] as String,
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'uid': instance.uid,
      'event_title': instance.eventTitle,
      'event_type': _$EventTypeEnumMap[instance.eventType],
      'event_start_time': instance.eventStartTime?.toIso8601String(),
      'event_end_time': instance.eventEndTime?.toIso8601String(),
      'event_description': instance.eventDescription,
      'location_name': instance.locationName,
      'starred': instance.starred,
      'event_icon': instance.eventIcon,
      'ws_presenter_names': instance.wsPresenterNames,
      'ws_urls': instance.wsUrls,
      'ws_skill_level': instance.wsSkillLevel,
      'ws_relevant_skills': instance.wsRelevantSkills,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$EventTypeEnumMap = {
  EventType.ACTIVITY: 'activity',
  EventType.WORKSHOP: 'workshop',
  EventType.MEAL: 'meal',
};
