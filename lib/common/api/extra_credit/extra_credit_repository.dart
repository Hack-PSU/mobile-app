import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../api_response.dart';
import '../client.dart';
import 'extra_credit_assignment_model.dart';
import 'extra_credit_class_model.dart';

class ExtraCreditRepository {
  ExtraCreditRepository(
    String configUrl,
  ) : _endpoint = configUrl;

  final String _endpoint;

  Future<List<ExtraCreditClass>> getClasses() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final token = await user.getIdToken();
      final client = Client.withToken(token);

      final resp = await client.get(Uri.parse("$_endpoint?ignoreCache=true"));

      if (resp.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(jsonDecode(resp.body));
        return (apiResponse.body["data"] as List)
            .map((data) =>
                ExtraCreditClass.fromJson(data as Map<String, dynamic>))
            .toList();
      }
    }
    return [];
  }

  Future<List<ExtraCreditAssignment>> getClassAssignmentsByUid(
    String uid,
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final token = await user.getIdToken();
      final client = Client.withToken(token);

      final resp = await client.get(
        Uri.parse(
          "$_endpoint/assignment?type=user&uid=$uid&ignoreCache=true",
        ),
      );

      if (resp.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(jsonDecode(resp.body));
        return (apiResponse.body["data"] as List)
            .map((c) =>
                ExtraCreditAssignment.fromJson(c as Map<String, dynamic>))
            .toList();
      }
    }
    return [];
  }

  Future<void> registerClass(int uid) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final token = await user.getIdToken();
      final client = Client.withToken(token);

      await client.post(
        Uri.parse(_endpoint),
        body: json.encode({
          "classUid": uid.toString(),
        }),
      );
    }
  }

  Future<void> unregisterClass(int uid) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final token = await user.getIdToken();
      final client = Client.withToken(token);

      await client.post(
        Uri.parse("$_endpoint/delete"),
        body: json.encode({
          "uid": uid.toString(),
        }),
      );
    }
  }
}
