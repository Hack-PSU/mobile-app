import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../client.dart';
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

    if (resp.statusCode == 200) {
      return model.User.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> deleteUser() async {
    final user = _firebaseAuth.currentUser;

    if (user != null &&
        user.uid != "FHBbkIw88qZBaxSmQxmdtSURsto1" &&
        user.uid != "gsOwfFcUHKfmRHTsmI7N1k7Ocie2") {
      final client = Client();
      await client.delete(Uri.parse("$_baseUrl/users/${user.uid}"));
    } else {
      throw Exception("Cannot delete admin user");
    }
  }
}
