import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../api_response.dart';
import '../client.dart';
import 'extra_credit_class_model.dart';

class ExtraCreditRepository {
  ExtraCreditRepository(
    String configUrl,
  ) : _endpoint = Uri.parse(configUrl);

  final Uri _endpoint;

  Future<List<ExtraCreditClass>> getClasses() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final token = await user.getIdToken();
      final client = Client.withToken(token);

      final resp = await client.get(_endpoint);

      if (resp.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(jsonDecode(resp.body));
        return (apiResponse.body["data"] as List)
            .map((data) =>
                ExtraCreditClass.fromJson(data as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Failed to get events from API");
      }
    }
    return [];
  }
}
