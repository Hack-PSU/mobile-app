import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../services/api_client.dart';

enum _Method { GET, POST }

class NotificationRepository {
  NotificationRepository(
    String configUrl, {
    FirebaseAuth firebaseAuth,
  })  : _url = configUrl,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _fcm = FirebaseMessaging.instance;

  final String _url;
  final FirebaseAuth _firebaseAuth;
  final FirebaseMessaging _fcm;

  Stream<String> get onTokenRefresh => _fcm.onTokenRefresh;

  Future<String> _getUserIdToken() async {
    final user = _firebaseAuth.currentUser;
    return user.getIdToken();
  }

  Future<void> register(String pin, [String fcmToken = ""]) async {
    final token = await _getUserIdToken();
    if (fcmToken == "") {
      fcmToken = await _fcm.getToken();
    }
    if (kDebugMode) {
      print(fcmToken);
    }
    try {
      final response = await http.post(
        Uri.parse('$_url/user/register'),
        headers: {
          "idtoken": token,
        },
        body: {
          "userPin": pin,
          "fcmToken": fcmToken,
        },
      );
      final resp = jsonDecode(response.body);
      if (resp["status"] == "ERROR") {
        throw Exception("Unauthorized");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Unable to register device");
    }
  }

  Future<void> subscribeAll(String pin) async {
    final token = await _getUserIdToken();
    final client = ApiClient.withToken(token);

    try {
      client
          .post(Uri.parse("$_url/user/subscribe/all"), body: {"userPin": pin});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Unable to subscribe to broadcast");
    } finally {
      client.close();
    }
  }

  Future<void> unsubscribeAll(String pin) async {
    final token = await _getUserIdToken();
    final client = ApiClient.withToken(token);

    try {
      await client.post(
        Uri.parse("$_url/user/unsubscribe/all"),
        body: {
          "userPin": pin,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Unable to unsubscribe to broadcast");
    }
  }

  Future<void> subscribeEvent(String pin, String uid) async {
    final token = await _getUserIdToken();
    final client = ApiClient.withToken(token);

    try {
      await client.post(Uri.parse("$_url/user/subscribe/$uid"), body: {
        "userPin": pin,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Unable to subscribe to event: $uid");
    }
  }

  Future<void> unsubscribeEvent(String pin, String uid) async {
    final token = await _getUserIdToken();
    final client = ApiClient.withToken(token);

    try {
      await client.post(Uri.parse("$_url/user/unsubscribe/$uid"), body: {
        "userPin": pin,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Unable to unsubscribe to event $uid");
    }
  }
}
