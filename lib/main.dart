import 'dart:io';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import './app_entry.dart';
import './utils/flavor_constants.dart';
import 'services/push_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();

  final PushNotificationService notificationService = PushNotificationService();
  notificationService.init();

  Config.appFlavor = Flavor.PROD;
  HttpOverrides.global = MyHttpOverrides();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}
