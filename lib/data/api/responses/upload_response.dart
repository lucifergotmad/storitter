class UploadResponse {
  UploadResponse({
    required this.error,
    required this.message,
  });

  final bool error;
  final String message;

  factory UploadResponse.fromJson(Map<String, dynamic> json) => UploadResponse(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
