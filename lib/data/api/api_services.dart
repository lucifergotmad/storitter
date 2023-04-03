import 'package:dio/dio.dart';
import 'package:storitter/data/api/requests/login_request.dart';
import 'package:storitter/data/api/requests/register_request.dart';
import 'package:storitter/data/api/responses/login_response.dart';
import 'package:storitter/data/api/responses/register_response.dart';

class ApiServices {
  final Dio client;

  static const String baseUrl = "https://story-api.dicoding.dev/v1";

  ApiServices({required this.client});

  Future<RegisterResponse> registerUser(RegisterRequest body) async {
    final response = await client.post(
      "$baseUrl/register",
      data: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterResponse.fromJson(response.data);
    } else {
      throw Exception("Failed to register!");
    }
  }

  Future<LoginResponse> loginUser(LoginRequest body) async {
    final response = await client.post("$baseUrl/login", data: body);

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception("Failed to login!");
    }
  }
}
