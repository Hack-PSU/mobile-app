import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../client.dart';

class NotificationRepository {
  NotificationRepository(
    String configUrl,
  )   : _endpoint = configUrl,
        _fcm = FirebaseMessaging.instance;

  final String _endpoint;
  final FirebaseMessaging _fcm;

  Stream<String> get onTokenRefresh => _fcm.onTokenRefresh;

  Future<void> register([String? fcmToken = ""]) async {
    if (fcmToken == "") {
      fcmToken = await _fcm.getToken();
    }

    if (kDebugMode) {
      print(fcmToken);
    }

    final client = Client();

    try {
      await client.post(Uri.parse("$_endpoint/register/device/$fcmToken"));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
