import 'package:flutter/material.dart';
import 'package:storitter/data/preferences/preferences_helper.dart';

class AppProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  AppProvider({required this.preferencesHelper}) {
    _loginStatus();
  }

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  String _token = "";

  String get token => _token;

  void _loginStatus() async {
    if (_token.isEmpty) {
      _isLoggedIn = false;
    } else {
      _isLoggedIn = true;
    }

    notifyListeners();
  }

  void getToken() async {
    _token = await preferencesHelper.token;
    notifyListeners();
    _loginStatus();
  }

  void saveToken(String value) {
    preferencesHelper.saveToken(value);
  }
}
