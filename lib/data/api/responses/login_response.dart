import 'package:json_annotation/json_annotation.dart';
import 'package:storitter/data/model/user.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  LoginResponse({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  final bool error;
  final String message;
  final User loginResult;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
