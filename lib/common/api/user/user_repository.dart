import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../api_response.dart';
import '../client.dart';
import 'user_model.dart' as model;

class UserRepository {
  UserRepository(
    String configUrl, {
    FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _endpoint = configUrl;

  final String _endpoint;
  final FirebaseAuth _firebaseAuth;

  Future<List<model.User>> getUserRegistrations() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      final String idToken = await user.getIdToken();
      final client = Client.withToken(idToken);

      final resp = await client.get(
        Uri.parse("$_endpoint/register?ignoreCache=true"),
      );

      if (resp.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(json.decode(resp.body));

        return (apiResponse.body["data"] as List)
            .map((user) => model.User.fromJson(user as Map<String, dynamic>))
            .toList();
      }
    }

    return [];
  }

  Future<String?> getUserUid() async {
    final users = await getUserRegistrations();
    final currentRegistration = users.where((user) => user.active == true);
    
    if (currentRegistration.isNotEmpty) {
      final user = currentRegistration.elementAt(0);

      return user.uid;
    }

    return "";
  }

  Future<void> deleteUser() async {
    final user = _firebaseAuth.currentUser;

    if (user != null &&
        user.uid != "FHBbkIw88qZBaxSmQxmdtSURsto1" &&
        user.uid != "gsOwfFcUHKfmRHTsmI7N1k7Ocie2") {
      final token = await user.getIdToken();
      final client = Client.withToken(token);

      await client.post(
        Uri.parse("$_endpoint/delete"),
        body: jsonEncode({
          "uid": user.uid,
        }),
      );
    } else {
      throw Exception("Cannot delete admin user");
    }
  }
}
