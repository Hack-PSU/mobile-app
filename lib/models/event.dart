import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

enum EventType {
  @JsonValue("activity")
  ACTIVITY,
  @JsonValue("workshop")
  WORKSHOP,
  @JsonValue('food')
  FOOD,
}

@JsonSerializable(
    createFactory: true, createToJson: true, fieldRename: FieldRename.snake)
class Event {
  Event({
    @required this.uid,
    @required this.eventTitle,
    @required this.eventType,
    @required this.eventStartTime,
    @required this.eventEndTime,
    @required this.eventDescription,
    @required this.locationName,
    this.starred = false,
    @required this.eventIcon,
    @required this.wsPresenterNames,
    @required this.wsUrls,
    this.wsRelevantSkills,
    this.wsSkillLevel,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  static DateTime _eventTimeFromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int);

  final String uid;
  final String eventTitle;
  EventType eventType;

  @JsonKey(fromJson: _eventTimeFromJson)
  final DateTime eventStartTime;

  @JsonKey(fromJson: _eventTimeFromJson)
  final DateTime eventEndTime;
  final String eventDescription;
  final String locationName;
  bool starred;
  final String eventIcon;
  final String wsPresenterNames;
  final List<String> wsUrls;
  final String wsSkillLevel;
  final String wsRelevantSkills;
}
