import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../client.dart';
import 'sponsor_model.dart';

class SponsorshipRepository {
  SponsorshipRepository(
    String baseUrl,
  )   : _baseUrl = baseUrl,
        _firebaseAuth = FirebaseAuth.instance;

  final String _baseUrl;
  final FirebaseAuth _firebaseAuth;

  Future<List<Sponsor>> getAllSponsors() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      final client = Client();

      final resp = await client.get(Uri.parse("$_baseUrl/sponsors"));

      if (resp.statusCode == 200) {
        final apiResp = jsonDecode(resp.body);
        return (apiResp as List)
            .map((sponsor) => Sponsor.fromJson(sponsor as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Failed to get sponsors from API");
      }
    }
    return [];
  }
}
