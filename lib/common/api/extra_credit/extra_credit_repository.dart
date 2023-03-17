import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../api_response.dart';
import '../client.dart';
import 'extra_credit_class_model.dart';

class ExtraCreditRepository {
  ExtraCreditRepository(
    String baseUrl,
  ) : _baseUrl = baseUrl;

  final String _baseUrl;

  Future<List<ExtraCreditClass>> getAllClasses() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final client = Client();

      final resp = await client.get(
        Uri.parse("$_baseUrl/extra-credit/classes"),
      );

      if (resp.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(json.decode(resp.body));
        return (apiResponse.body as List)
            .map(
              (data) => ExtraCreditClass.fromJson(data as Map<String, dynamic>),
            )
            .toList();
      }
    }
    return [];
  }

  Future<List<ExtraCreditClass>> getClassesForUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final client = Client();
      final resp = await client.get(
        Uri.parse("$_baseUrl/users/${user!.uid}/extra-credit/classes"),
      );

      if (resp.statusCode == 200) {
        final apiResp = ApiResponse.fromJson(resp.body);
        return (apiResp.body as List)
            .map(
              (data) => ExtraCreditClass.fromJson(data as Map<String, dynamic>),
            )
            .toList();
      }
    }
    return [];
  }

  Future<void> registerClass(int id) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final client = Client();
      await client.post(
        Uri.parse("$_baseUrl/users/${user.uid}/extra-credit/assign/$id"),
      );
    }
  }

  Future<void> unregisterClass(int id) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final client = Client();
      await client.post(
        Uri.parse("$_baseUrl/users/${user.uid}/extra-credit/unassign/$id"),
      );
    }
  }
}
