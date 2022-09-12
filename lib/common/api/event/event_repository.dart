import 'dart:convert';

import '../api_response.dart';
import '../client.dart';
import 'event_model.dart';

class EventRepository {
  EventRepository(String configUrl) : _endpoint = Uri.parse(configUrl);

  final Uri _endpoint;

  Future<List<Event>> getEvents() async {
    final client = Client<List<Map<String, dynamic>>>();

    final resp = await client.get(_endpoint);

    if (resp.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(jsonDecode(resp.body));

      return (apiResponse.body["data"] as List)
          .map((event) => Event.fromJson(event as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Failed to get events from API");
    }
  }
}
