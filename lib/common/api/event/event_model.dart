import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

enum EventType {
  @JsonValue("activity")
  ACTIVITY,
  @JsonValue("workshop")
  WORKSHOP,
  @JsonValue('food')
  FOOD,
  @JsonValue("checkIn")
  CHECKIN,
}

@JsonSerializable(
  createFactory: true,
  createToJson: true,
)
class Location {
  Location({
    required this.id,
    required this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  final String? id;
  final String? name;
}

@JsonSerializable(
  createFactory: true,
  createToJson: true,
)
class Event {
  Event({
    required this.id,
    required this.name,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.location,
    required this.icon,
    required this.wsPresenterNames,
    required this.wsRelevantSkills,
    required this.wsSkillLevel,
    required this.wsUrls,
    this.starred = false,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  static DateTime _eventTimeFromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int);

  final String? id;
  final String? name;
  EventType? type;

  @JsonKey(fromJson: _eventTimeFromJson)
  final DateTime startTime;

  @JsonKey(fromJson: _eventTimeFromJson)
  final DateTime endTime;
  final String? description;
  final Location? location;
  bool? starred;
  final String? icon;
  final String? wsPresenterNames;
  final List<String>? wsUrls;
  final String? wsSkillLevel;
  final String? wsRelevantSkills;
}
