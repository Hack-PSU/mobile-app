import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:hackpsu/data/event_repository.dart';

import './app_entry.dart';
import './utils/flavor_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Config.appFlavor = Flavor.DEV;
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}
