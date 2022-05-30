import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../models/registration.dart';

class UserRepository {
  UserRepository(
    String configUrl, {
    FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _endpoint = Uri.parse(configUrl);

  final FirebaseAuth _firebaseAuth;
  final Uri _endpoint;

  Future<List<Registration>> getUserInfo() async {
    final user = _firebaseAuth.currentUser!;
    final String idToken = await user.getIdToken();

    final resp = await http.get(
      _endpoint,
      headers: {"idToken": idToken},
    );

    if (resp.statusCode == 200) {
      final parsed =
          jsonDecode(resp.body)['body']['data'].cast<Map<String, dynamic>>();
      return parsed
          .map<Registration>(
              (Map<String, dynamic> json) => Registration.fromJson(json))
          .toList() as List<Registration>;
    } else {
      throw Exception('Failed to get user info from API');
    }
  }

  Future<String> getUserPin() async {
    final registrations = await getUserInfo();
    final hackathons = registrations.where((r) => r.active == true);
    // registrations.forEach((element) {
    //   print(element.uid);
    // });
    // final active = registrations.where((r) {
    //   print(r.toString());
    //   return r.active == true;
    // });
    // print(active);
    if (hackathons != null && hackathons.isNotEmpty) {
      final currentHackathon = hackathons.last;
      return (currentHackathon.pin! - currentHackathon.basePin!).toString();
    }
    return "";
  }
}
