class RegisterResponse {
  RegisterResponse({
    required this.error,
    required this.message,
  });

  final bool error;
  final String message;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}