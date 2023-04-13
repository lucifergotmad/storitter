import 'package:flutter/material.dart';
import 'package:storitter/data/preferences/preferences_helper.dart';

class AppProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  AppProvider({required this.preferencesHelper});

  String _token = "";

  String get token => _token;

  Future<void> getToken() async {
    _token = await preferencesHelper.token;
    notifyListeners();
  }

  void saveToken(String value) {
    preferencesHelper.saveToken(value);
  }

  void removeToken() {
    preferencesHelper.removeToken();
  }
}
