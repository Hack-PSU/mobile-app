import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  Future<void> register(String pin) async {
    final user = _firebaseAuth.currentUser;
    final token = await user.getIdToken();
    final fcmToken = await _fcm.getToken();
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
}
