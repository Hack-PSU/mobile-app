import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackpsu/models/registration.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  UserRepository(
    String configUrl, {
    FirebaseAuth firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _endpoint = Uri.parse(configUrl);

  final FirebaseAuth _firebaseAuth;
  final Uri _endpoint;

  Future<List<Registration>> getUserInfo() async {
    final user = _firebaseAuth.currentUser;
    final idToken = await user.getIdToken();

    final resp = await http.get(
      _endpoint,
      headers: {"idToken": idToken},
    );

    if (resp.statusCode == 200) {
      final parsed =
          jsonDecode(resp.body)['body']['data'].cast<Map<String, dynamic>>();
      return parsed
          .map<Registration>((json) => Registration.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to get user info from API');
    }
  }
}
