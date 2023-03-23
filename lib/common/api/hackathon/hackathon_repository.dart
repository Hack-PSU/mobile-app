import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../client.dart';
import 'hackathon_model.dart';

class HackathonRepository {
  HackathonRepository(
    String baseUrl,
  ) : _baseUrl = baseUrl;

  final String _baseUrl;

  Future<Hackathon?> getActiveHackathon() async {
    final client = Client();

    try {
      final resp = await client.get(
        Uri.parse("$_baseUrl/hackathons/active/static"),
      );

      if (resp.statusCode == 200) {
        return Hackathon.fromJson(
          jsonDecode(resp.body) as Map<String, dynamic>,
        );
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    } finally {
      client.close();
    }

    return null;
  }
}
