import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/event.dart';

class EventRepository {
  EventRepository(String configUrl) : _endpoint = Uri.parse(configUrl);

  final Uri _endpoint;

  Future<List<Event>> getEvents() async {
    final resp = await http.get(_endpoint);

    if (resp.statusCode == 200) {
      final parsed =
          jsonDecode(resp.body)['body']['data'].cast<Map<String, dynamic>>();
      return parsed
          .map<Event>((Map<String, dynamic> json) => Event.fromJson(json))
          .toList() as List<Event>;
    } else {
      throw Exception('Failed to get events from API');
    }
  }
}
