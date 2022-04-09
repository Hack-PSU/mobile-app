import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SponsorshipRepository {
  SponsorshipRepository({
    @required String bucket,
  }) : _firebaseStorage = FirebaseStorage.instanceFor(
          bucket: bucket,
        );

  final FirebaseStorage _firebaseStorage;
  final orderRegex = RegExp(".*ORDER-([0-9]+)");

  Future<List<Map<String, String>>> getSponsors() async {
    final storageRef = _firebaseStorage.ref().child("sponsorship-logos");
    final allLogos = await storageRef.listAll();
    final Map<String, String> refMap = <String, String>{};
    final logos =
        allLogos.items.where((ref) => ref.fullPath.contains("ENABLED"));

    final List<Map<String, String>> sponsorData = List.filled(logos.length, {});
    // final Map<String, Map<String, String>> sponsorData = {};

    for (final Reference logo in logos) {
      final order = orderRegex.allMatches(logo.fullPath).elementAt(0).group(1);
      final metadata = await logo.getMetadata();
      sponsorData[int.parse(order) - 1] = {
        "image": await logo.getDownloadURL(),
        "url": metadata.customMetadata["url"]
      };
    }

    return sponsorData;
  }
}
