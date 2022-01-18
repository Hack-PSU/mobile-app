import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../utils/flavor_constants.dart';
import '../models/event.dart';

class Api {
  static Future<List<Event>> getEvents() async {
    var url = Uri.parse(Config.baseUrl + '/live/events');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body)['body']['data']
          .cast<Map<String, dynamic>>();
      return parsed.map<Event>((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get events from API');
    }
  }
}
