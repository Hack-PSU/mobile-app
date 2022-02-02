import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum EventType { ACTIVITY, WORKSHOP, MEAL }

class Event {
  final String uid;
  final String eventTitle;
  EventType _eventType;
  final DateTime eventStartTime;
  final DateTime eventEndTime;
  final String eventDescription;
  final String locationName;
  bool starred;
  final String eventIcon;
  final String wsPresenterNames;
  final List<dynamic> wsUrls;
  final String wsSkillLevel;
  final String wsRelevantSkills;

  Event({
    @required this.uid,
    @required this.eventTitle,
    @required String eventType,
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
  }) {
    switch (eventType) {
      case 'workshop':
        this._eventType = EventType.WORKSHOP;
        break;
      case 'activity':
        this._eventType = EventType.ACTIVITY;
        break;
      case 'meal':
      default:
        this._eventType = EventType.MEAL;
    }
  }
  EventType get eventType => _eventType;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        uid: json['uid'],
        eventTitle: json['event_title'],
        eventType: json['event_type'],
        eventStartTime:
            DateTime.fromMillisecondsSinceEpoch(json['event_start_time']),
        eventEndTime:
            DateTime.fromMillisecondsSinceEpoch(json['event_end_time']),
        eventDescription: json['event_description'],
        locationName: json['location_name'],
        eventIcon: json['event_icon'],
        wsPresenterNames: json['ws_presenter_names'],
        wsUrls: json['ws_urls']);
  }
}