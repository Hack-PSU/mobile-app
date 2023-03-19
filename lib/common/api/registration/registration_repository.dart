import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../client.dart';
import 'registration_body_model.dart';
import 'registration_model.dart';

class RegistrationRepository {
  RegistrationRepository(
    String baseUrl,
  )   : _baseUrl = baseUrl,
        _firebaseAuth = FirebaseAuth.instance;

  final String _baseUrl;
  final FirebaseAuth _firebaseAuth;

  Future<Registration?> registerUser(RegistrationBody registration) async {
    final user = _firebaseAuth.currentUser;
    final client = Client(contentType: "application/json");

    if (user != null) {
      try {
        final resp = await client.post(
          Uri.parse("$_baseUrl/users/${user.uid}/register"),
          body: jsonEncode(registration.toJson()),
        );
        return Registration.fromJson(
          jsonDecode(resp.body) as Map<String, dynamic>,
        );
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
    return null;
  }
}
