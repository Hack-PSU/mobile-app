import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../client.dart';

class NotificationRepository {
  NotificationRepository(
    String configUrl, {
    FirebaseAuth? firebaseAuth,
  })  : _endpoint = configUrl,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _fcm = FirebaseMessaging.instance;

  final String _endpoint;
  final FirebaseAuth _firebaseAuth;
  final FirebaseMessaging _fcm;

  Stream<String> get onTokenRefresh => _fcm.onTokenRefresh;

  Future<String> _getUserIdToken() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      return user.getIdToken();
    }

    return "";
  }

  Future<void> register(String? pin, [String? fcmToken = ""]) async {
    final token = await _getUserIdToken();
    if (fcmToken == "") {
      fcmToken = await _fcm.getToken();
    }
    if (kDebugMode) {
      print(fcmToken);
    }

    final client = Client.withToken(token);

    try {
      await client.post(
        Uri.parse("$_endpoint/user/ping"),
        body: jsonEncode({
          "userPin": pin,
          "fcmToken": fcmToken,
        }),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> subscribeAll(String? pin) async {
    final token = await _getUserIdToken();
    final client = Client.withToken(token);

    try {
      await client.post(Uri.parse("$_endpoint/user/$pin/subscribe/all"));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // throw Exception("Unable to subscribe to broadcast");
    } finally {
      client.close();
    }
  }

  Future<void> unsubscribeAll(String pin) async {
    final token = await _getUserIdToken();
    final client = Client.withToken(token);

    try {
      await client.post(Uri.parse("$_endpoint/user/$pin/unsubscribe/all"));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // throw Exception("Unable to unsubscribe to broadcast");
    } finally {
      client.close();
    }
  }

  Future<void> subscribeEvent(String? pin, String? uid) async {
    final token = await _getUserIdToken();
    final client = Client.withToken(token);

    try {
      await client.post(Uri.parse("$_endpoint/user/$pin/subscribe/$uid"));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // throw Exception("Unable to subscribe to event: $uid");
    } finally {
      client.close();
    }
  }

  Future<void> unsubscribeEvent(String? pin, String? uid) async {
    final token = await _getUserIdToken();
    final client = Client.withToken(token);

    try {
      await client.post(Uri.parse("$_endpoint/user/$pin/unsubscribe/$uid"));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // throw Exception("Unable to unsubscribe to event: $uid");
    } finally {
      client.close();
    }
  }
}
