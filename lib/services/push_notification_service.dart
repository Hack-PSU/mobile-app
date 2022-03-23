import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init() async {
    if (Platform.isIOS) {
      // request permissions if in iOS
      await _fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications', // description
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (!kIsWeb) {
      // create Android Notification channel
      // overrides default FCM channel
      if (flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>() !=
          null) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            .createNotificationChannel(channel);
      }

      // Update iOS foreground notification presentation
      await _fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    print(await _fcm.getToken());

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        final RemoteNotification notification = message.notification;
        final AndroidNotification android = message.notification.android;

        if (notification != null && android != null && !kIsWeb) {
          //
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launch_background',
              ),
            ),
          );
        }

        print(
            "Message: ${message.notification.title}, ${message.notification.body}");
      },
    );
  }
}
