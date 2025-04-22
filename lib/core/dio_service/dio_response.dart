class DioResponse {
  final Map<String, dynamic> data;
  final int statusCode;
  final String? statusMessage;

  const DioResponse({
    required this.data,
    required this.statusCode,
    this.statusMessage,
  });

  factory DioResponse.fromJson(Map<String, dynamic> json) {
    return DioResponse(
      data: json['data'] as Map<String, dynamic>,
      statusCode: json['statusCode'] as int,
      statusMessage: json['statusMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'statusCode': statusCode,
      'statusMessage': statusMessage,
    };
  }
}
