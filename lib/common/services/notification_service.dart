import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher_string.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> _showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    RemoteMessage message,
    AndroidNotificationChannel channel,
  ) async {
    final RemoteNotification notification = message.notification!;

    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: "ic_hackpsu_logo",
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  Future<void> _scheduleNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    RemoteMessage message,
    AndroidNotificationChannel channel,
  ) async {
    final RemoteNotification notification = message.notification!;
    final Map<String, dynamic> data = message.data;

    final tz.TZDateTime scheduleTime = tz.TZDateTime.fromMillisecondsSinceEpoch(
      tz.local,
      int.parse(data["scheduleTime"] as String),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notification.hashCode,
      notification.title,
      notification.body,
      scheduleTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: "ic_hackpsu_logo",
        ),
      ),
      payload: jsonEncode(data),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> _onSelectNotification(NotificationResponse details) async {
    final data = json.decode(details.payload!);
    if (data["link"] != null) {
      final String link = data["link"] as String;
      if (kDebugMode) {
        print(link);
      }

      if (await canLaunchUrlString(link)) {
        launchUrlString(link, mode: LaunchMode.inAppWebView);
      }
    }
  }

  Future<void> init() async {
    if (Platform.isIOS) {
      // request permissions if in IOS
      await _fcm.requestPermission();
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
      iOS: DarwinInitializationSettings(),
    );

    tz_data.initializeTimeZones();

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );

    if (!kIsWeb) {
      // create Android Notification channel
      // overrides default FCM channel
      if (flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>() !=
          null) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()!
            .createNotificationChannel(channel);
      }

      // Update iOS foreground notification presentation
      // Disable default iOS notification to use Flutter Local Notifications
      await _fcm.setForegroundNotificationPresentationOptions();
    }

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        final RemoteNotification? notification = message.notification;
        final AndroidNotification? android = message.notification!.android;
        final Map<String, dynamic> data = message.data;

        print(notification);

        if (notification != null && !kIsWeb) {
          if (data != null &&
              data.containsKey("isScheduled") &&
              data["isScheduled"] == "true") {
            _scheduleNotification(
              flutterLocalNotificationsPlugin,
              message,
              channel,
            );
          } else {
            _showNotification(
              flutterLocalNotificationsPlugin,
              message,
              channel,
            );
          }
        }
        if (kDebugMode) {
          print(
            "Message: ${message.notification!.title}, ${message.notification!.body}",
          );
        }
      },
    );
  }
}
