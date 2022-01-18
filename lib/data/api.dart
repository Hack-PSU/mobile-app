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
      var thingy = parsed.map<Event>((json) => Event.fromJson(json)).toList();
      return thingy;
      //return jsonDecode(response.body)['body']['data'];
    } else {
      throw Exception('Failed to load from API');
    }
  }
}
