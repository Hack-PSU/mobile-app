import 'package:hackpsu/models/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../utils/flavor_constants.dart';

class Api {
  Future<Event> getEvents() async {
    var url = Uri.parse(Config.baseUrl + '/live/events');
    var response = await http.get(url);

    // TODO: if the app breaks change this back to var
    // Map(String, dynamic) jsonResponse = convert.jsonDecode(response.body)

    if (response.statusCode == 200) {
      return Event.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load from API');
    }
  }
}
