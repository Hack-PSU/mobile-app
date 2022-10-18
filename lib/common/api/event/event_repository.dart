import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../api_response.dart';
import '../client.dart';
import 'event_model.dart';

class EventRepository {
  EventRepository(
    String configUrl,
  )   : _endpoint = Uri.parse(configUrl),
        _firebaseAuth = FirebaseAuth.instance;

  final Uri _endpoint;
  final FirebaseAuth _firebaseAuth;

  Future<List<Event>> getEvents() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      final token = await user.getIdToken();
      final client = Client.withToken(token);

      final resp = await client.get(_endpoint);

      if (resp.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(jsonDecode(resp.body));

        return (apiResponse.body["data"] as List)
            .map((event) => Event.fromJson(event as Map<String, dynamic>))
            .toList();
      } else if (resp.statusCode == 204) {
        return [];
      } else {
        throw Exception("Failed to get events from API");
      }
    }
    return [];
  }
}
