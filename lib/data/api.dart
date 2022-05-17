import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../models/event.dart';
import '../models/registration.dart';
import '../utils/flavor_constants.dart';

class Api {
  static Future<List<Event>?> getEvents() async {
    final Uri url = Uri.parse('${Config.baseUrl}/live/events');
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed =
          jsonDecode(response.body)['body']['data'].cast<Map<String, Event>>();
      return parsed.map<Event>(
          (Map<String, dynamic> json) => Event.fromJson(json)) as List<Event>?;
    } else {
      throw Exception('Failed to get events from API');
    }
  }

  static Future<List<Registration>?> getUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    final Future<String> userToken = user.getIdToken(); // Type: Future<String>
    String idToken = await userToken; // Type: String

    // Convert the Future<String> into String
    userToken.then((value) {
      idToken = value;
    });

    final url = Uri.parse('${Config.baseUrl}/users/register');
    final response = await http.get(url, headers: {
      "idToken": idToken,
    });
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body)['body']['data']
          .cast<Map<String, dynamic>>();
      return parsed
          .map<Registration>(
              (Map<String, dynamic> json) => Registration.fromJson(json))
          .toList() as List<Registration>?;
    } else {
      throw Exception('Failed to get user info from API');
    }
  }
}
