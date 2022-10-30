class ApiResponse {
  ApiResponse({
    required this.apiResponse,
    required this.status,
    required this.body,
  });

  factory ApiResponse.fromJson(dynamic json) => ApiResponse(
        apiResponse: json["api_response"] as String?,
        status: json["status"] as int?,
        body: json["body"] as Map<String, dynamic>,
      );

  String? apiResponse;
  int? status;
  Map<String, dynamic> body;
}
