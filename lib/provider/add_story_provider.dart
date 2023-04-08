import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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

  Future<void> uploadStory(String token, File file, String description) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiServices.uploadStory(token, file, description);
      if (response.error) {
        _state = ResultState.error;
      } else {
        _state = ResultState.success;
      }
      _message = response.message;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: ($e)';
      notifyListeners();
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
