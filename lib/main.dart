import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import './app_entry.dart';
import './utils/flavor_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Config.appFlavor = Flavor.PROD;
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}
