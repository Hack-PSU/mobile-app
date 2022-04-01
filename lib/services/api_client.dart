import 'package:http/http.dart' as http;

class ApiClient extends http.BaseClient {
  ApiClient({
    Map<String, String> headers,
  }) : _headers = headers;

  ApiClient.withToken(String token)
      : this(
          headers: {
            "idtoken": token,
          },
        );

  final http.Client _httpClient = http.Client();
  final Map<String, String> _headers;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _httpClient.send(request);
  }
}
