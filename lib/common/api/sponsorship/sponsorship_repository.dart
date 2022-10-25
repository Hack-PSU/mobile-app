import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../api_response.dart';
import '../client.dart';
import 'sponsor_model.dart';

class SponsorshipRepository {
  SponsorshipRepository(
    String configUrl,
  )   : _endpoint = configUrl,
        _firebaseAuth = FirebaseAuth.instance;

  final String _endpoint;
  final FirebaseAuth _firebaseAuth;

  Future<List<Sponsor>> getAllSponsors() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      final String token = await user.getIdToken();
      final client = Client.withToken(token);

      final resp = await client.get(Uri.parse("$_endpoint/all"));

      if (resp.statusCode == 200 && resp.body.isNotEmpty) {
        final apiResponse = ApiResponse.fromJson(jsonDecode(resp.body));

        return (apiResponse.body["data"] as List)
            .map((sponsor) => Sponsor.fromJson(sponsor as Map<String, dynamic>))
            .toList();
      } else if (resp.statusCode == 204) {
        return [];
      } else {
        throw Exception("Failed to get sponsors from API");
      }
    }

    return [];
  }
}
