import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../api_response.dart';
import '../client.dart';
import 'extraCreditClasses_model.dart';



class ExtraCreditRepository {

  
  ExtraCreditRepository(String configUrl) : _endpoint = Uri.parse(configUrl);
  
  final Uri _endpoint;


  Future<String> getIDToken() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final String idToken = await user.getIdToken();
      final client = Client.withToken(idToken);

        return idToken;
        } else {
          throw Exception("Cant find ID token");
        } 
      }
  
  Future<List<extraCreditClass>> getClasses() async {
    final client = Client<List<Map<String, dynamic>>>();

    final resp = await client.get(_endpoint);

    if (resp.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(jsonDecode(resp.body));
     return (apiResponse.body["data"] as List)
          .map((extraCreditClass) => extraCreditClass.fromJson(event as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Failed to get events from API"); 
    }
  }

}


