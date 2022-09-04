import 'package:firebase_auth/firebase_auth.dart';

import '../client.dart';
import 'user_model.dart' as model;

class UserRepository {
  UserRepository(
    String configUrl, {
    FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _endpoint = Uri.parse(configUrl);

  final Uri _endpoint;
  final FirebaseAuth _firebaseAuth;

  Future<List<model.User>> getUserRegistrations() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      final String idToken = await user.getIdToken();
      final client =
          Client<List<Map<String, dynamic>>>(headers: {"idToken": idToken});

      final resp = await client.get(_endpoint);

      if (resp.statusCode == 200) {
        final body = client.extractData(resp);

        return body.map((user) => model.User.fromJson(user)).toList();
      }
    }

    return [];
  }

  Future<String> getUserPin() async {
    final users = await getUserRegistrations();
    final currentRegistration = users.where((user) => user.active == true);

    if (currentRegistration.isNotEmpty) {
      final user = currentRegistration.elementAt(0);

      return (user.pin! - user.basePin!).toString();
    }

    return "";
  }
}
