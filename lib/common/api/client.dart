import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_response.dart';

class Client<T> extends http.BaseClient {
  Client({Map<String, String>? headers}) : _headers = headers;

  Client.withToken(String token) : this(headers: {"idToken": token});

  final http.Client _client = http.Client();
  final Map<String, String>? _headers;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (_headers != null) {
      request.headers.addAll(_headers!);
    }
    return _client.send(request);
  }

  T? extractData(http.Response response) {
    if (response.body.isNotEmpty) {
      final apiResp = ApiResponse.fromJson(jsonDecode(response.body));
      return apiResp.body["data"] as T;
    }
    return null;
  }
}
