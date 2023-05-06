import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/result_state.dart';

class AddStoryProvider extends ChangeNotifier {
  final ApiServices apiServices;

  AddStoryProvider({required this.apiServices});

  ResultState _state = ResultState.idle;
  String _message = "";
  String? imagePath;
  XFile? imageFile;

  ResultState get state => _state;

  String get message => _message;

  Future<bool> uploadStory(String token, File file, String description, LatLng? latLng) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiServices.uploadStory(token, file, description, latLng);
      if (response.error) {
        _state = ResultState.error;
        _message = response.message;
        notifyListeners();
        return false;
      } else {
        _state = ResultState.success;
        _message = response.message;
        notifyListeners();
        return true;
      }

    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: ($e)';
      notifyListeners();
      return false;

    }
  }

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  void resetFile() {
    imagePath = null;
    imageFile = null;
    notifyListeners();
  }
}
