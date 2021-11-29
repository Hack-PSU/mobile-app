import 'package:hackpsu/models/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../utils/flavor_constants.dart';

class Api {
  static Future<List<dynamic>> getEvents() async {
    var url = Uri.parse(Config.baseUrl + '/live/events');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['body']['data'];
    } else {
      throw Exception('Failed to load from API');
    }
  }
}
