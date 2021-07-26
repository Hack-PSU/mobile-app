import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './app_entry.dart';
import './flavor_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Config.appFlavor = Flavor.DEV;
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}
