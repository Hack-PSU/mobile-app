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
  final orderRegex = RegExp(".*ORDER-([0-9]+)");

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

  // Future<List<Map<String, String>>> getSponsors() async {
  //   final storageRef = _firebaseStorage.ref().child("sponsorship-logos");
  //   final allLogos = await storageRef.listAll();
  //   final Map<String, String> refMap = <String, String>{};
  //   final logos =
  //       allLogos.items.where((ref) => ref.fullPath.contains("ENABLED"));
  //
  //   final List<Map<String, String>> sponsorData = List.filled(logos.length, {});
  //   // final Map<String, Map<String, String>> sponsorData = {};
  //
  //   for (final Reference logo in logos) {
  //     final order = orderRegex.allMatches(logo.fullPath).elementAt(0).group(1)!;
  //     final metadata = await logo.getMetadata();
  //     sponsorData[int.parse(order) - 1] = {
  //       "image": await logo.getDownloadURL(),
  //       "url": metadata.customMetadata!["url"] ?? ""
  //     };
  //   }
  //
  //   return sponsorData;
  // }
}
