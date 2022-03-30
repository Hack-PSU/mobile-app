import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> _onSelectNotification(String payload) async {
    final data = jsonDecode(payload);
    if (data != null && data["link"] != null) {
      final String link = data["link"] as String;
      await launch(link);
    }
  }

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

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("ic_hackpsu_logo"),
      iOS: IOSInitializationSettings(),
    );

    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _onSelectNotification,
    );

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

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        final RemoteNotification notification = message.notification;
        final AndroidNotification android = message.notification.android;
        final Map<String, dynamic> data = message.data;

        if (notification != null && android != null && !kIsWeb) {
          if (data != null && data["isScheduled"] == "true") {
            final tz.TZDateTime scheduleTime =
                tz.TZDateTime.fromMillisecondsSinceEpoch(
              tz.local,
              int.parse(
                data["scheduleTime"] as String,
              ),
            );
            flutterLocalNotificationsPlugin.zonedSchedule(
              notification.hashCode,
              notification.title,
              notification.body,
              scheduleTime,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: "launch_background",
                ),
              ),
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime,
              androidAllowWhileIdle: true,
            );
          } else {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: 'ic_hackpsu_logo',
                ),
              ),
              payload: jsonEncode(message.data),
            );
          }
        }
        print(
            "Message: ${message.notification.title}, ${message.notification.body}");
      },
    );
  }
}
