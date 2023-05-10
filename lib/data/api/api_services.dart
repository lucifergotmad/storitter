import 'dart:io';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:storitter/data/api/requests/login_request.dart';
import 'package:storitter/data/api/requests/register_request.dart';
import 'package:storitter/data/api/responses/get_detail_stories_response.dart';
import 'package:storitter/data/api/responses/get_stories_response.dart';
import 'package:storitter/data/api/responses/login_response.dart';
import 'package:storitter/data/api/responses/register_response.dart';
import 'package:storitter/data/api/responses/upload_response.dart';

class ApiServices {
  final Dio client;

  static const String baseUrl = "https://story-api.dicoding.dev/v1";

  ApiServices({required this.client});

  Future<RegisterResponse> registerUser(RegisterRequest body) async {
    final response = await client.post(
      "$baseUrl/register",
      data: body.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterResponse.fromJson(response.data);
    } else {
      throw Exception("Failed to register!");
    }
  }

  Future<LoginResponse> loginUser(LoginRequest body) async {
    final response = await client.post("$baseUrl/login", data: body.toJson());

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception("Failed to login!");
    }
  }

  Future<GetStoriesResponse> getStories(
    String token,
    int pageItems,
    int itemSize,
  ) async {
    final response = await client.get(
      "$baseUrl/stories",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
      queryParameters: {"page": pageItems, "size": itemSize},
    );

    if (response.statusCode == 200) {
      return GetStoriesResponse.fromJson(response.data);
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<GetDetailStoriesResponse> getDetailStories(
    String token,
    String id,
  ) async {
    final response = await client.get(
      "$baseUrl/stories/$id",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    if (response.statusCode == 200) {
      return GetDetailStoriesResponse.fromJson(response.data);
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<UploadResponse> uploadStory(
    String token,
    File file,
    String description,
    LatLng? latLng,
  ) async {
    print("latLng service $latLng");
    final FormData formData = FormData.fromMap({
      "photo": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split("/").last,
      ),
      "description": description,
      "lat": latLng?.latitude,
      "lon": latLng?.longitude,
    });

    final response = await client.post(
      "$baseUrl/stories",
      options: Options(
        contentType: "multipart/form-data",
        headers: {"Authorization": "Bearer $token"},
      ),
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UploadResponse.fromJson(response.data);
    } else {
      throw Exception("Failed to upload");
    }
  }
}
