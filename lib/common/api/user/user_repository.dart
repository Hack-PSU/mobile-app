import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../client.dart';
import 'user_body_model.dart';
import 'user_model.dart' as model;

class UserRepository {
  UserRepository(
    String baseUrl, {
    FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _baseUrl = baseUrl;

  final String _baseUrl;
  final FirebaseAuth _firebaseAuth;

  Future<model.User?> getUserProfile() async {
    final client = Client();
    final resp = await client.get(Uri.parse("$_baseUrl/users/info/me"));
    final body = jsonDecode(resp.body) as Map<String, dynamic>;

    if (resp.statusCode == 200 && body.isNotEmpty) {
      return model.User.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> createUserProfile(UserBody user) async {
    final client = Client(contentType: "application/json");
    final resp = await client.post(
      Uri.parse("$_baseUrl/users"),
      body: jsonEncode(user.toJson()),
    );
    if (kDebugMode) {
      print(resp.body);
    }
  }

  Future<void> deleteUser() async {
    final user = _firebaseAuth.currentUser;

    if (user != null &&
        user.uid != "FHBbkIw88qZBaxSmQxmdtSURsto1" &&
        user.uid != "gsOwfFcUHKfmRHTsmI7N1k7Ocie2") {
      final client = Client();
      final resp =
          await client.delete(Uri.parse("$_baseUrl/users/${user.uid}"));
    } else {
      throw Exception("Cannot delete admin user");
    }
  }
}
