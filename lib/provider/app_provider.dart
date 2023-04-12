import 'package:flutter/material.dart';
import 'package:storitter/data/preferences/preferences_helper.dart';

class AppProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  AppProvider({required this.preferencesHelper}) {
    getToken();
  }

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  String _token = "";

  String get token => _token;

  Future<void> getToken() async {
    _token = await preferencesHelper.token;
    notifyListeners();

    if (_token.isEmpty) {
      _isLoggedIn = false;
    } else {
      _isLoggedIn = true;
    }

    notifyListeners();
  }

  void saveToken(String value) {
    preferencesHelper.saveToken(value);
  }

  void removeToken() {
    preferencesHelper.removeToken();
  }
}
