import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../client.dart';
import 'event_model.dart';

class EventRepository {
  EventRepository(
    String baseUrl,
  )   : _firebaseAuth = FirebaseAuth.instance,
        _baseUrl = baseUrl;

  final String _baseUrl;
  final FirebaseAuth _firebaseAuth;

  Future<List<Event>> getEvents() async {
    final client = Client();
    final resp = await client.get(Uri.parse("$_baseUrl/events"));

    if (resp.statusCode == 200) {
      final apiResp = json.decode(resp.body);
      return (apiResp as List)
          .map((event) => Event.fromJson(event as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(resp.body);
    }
  }

  Future<void> subscribeTo(String eventId) async {
    final client = Client();
    try {
      await client.post(
        Uri.parse("$_baseUrl/events/$eventId/notifications/subscribe"),
      );
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<void> unsubscribeFrom(String eventId) async {
    final client = Client();
    try {
      await client.post(
        Uri.parse("$_baseUrl/events/$eventId/notifications/unsubscribe"),
      );
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
