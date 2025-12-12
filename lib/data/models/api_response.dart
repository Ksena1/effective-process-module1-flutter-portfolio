class ApiResponse<T> {
  final int code;
  final String status;
  final List<T> results;

  ApiResponse({
    required this.code,
    required this.status,
    required this.results,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJson) {
    return ApiResponse<T>(
      code: json['code'] ?? 0,
      status: json['status'] ?? '',
      results: (json['data']?['results'] as List?)
              ?.map((item) => fromJson(item))
              .toList() ??
          [],
    );
  }
}