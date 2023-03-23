import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Client<T> extends http.BaseClient {
  Client({Map<String, String>? headers, String? contentType})
      : _headers = headers,
        _contentType = contentType,
        _firebaseAuth = FirebaseAuth.instance;

  final http.Client _client = http.Client();
  final Map<String, String>? _headers;
  final String? _contentType;
  final FirebaseAuth _firebaseAuth;

  Future<String> getUserToken() async {
    if (_firebaseAuth.currentUser != null) {
      return _firebaseAuth.currentUser!.getIdToken();
    }
    return "";
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (_headers != null) {
      request.headers.addAll(_headers!);
    }

    final token = await getUserToken();
    request.headers.addAll({"Authorization": "Bearer $token"});

    if (_contentType != null) {
      request.headers.addAll({"Content-Type": _contentType!});
    }

    return _client.send(request);
  }
}
