import 'package:firebase_auth/firebase_auth.dart';
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
      getUserInfo();
      return parsed.map<Event>((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get events from API');
    }
  }

  static getUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    //var header = {'idToken': user.getIdToken().toString()};
    var userToken = user.getIdToken(); // Type: Future<String>
    var idToken = await userToken; // Type: String

    // Convert the Future<String> into String
    userToken.then((value) {
      idToken = value;
    });
    var url = Uri.parse(Config.baseUrl + '/users/register');
    var response = await http.get(url, headers: {
      "idToken": idToken,
    });
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body)['body']['data']
          .cast<Map<String, dynamic>>();
      print(parsed);
      //return parsed.map<Event>((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get user info from API');
    }
  }
}
