import 'package:flutter/material.dart';
import 'package:storitter/data/preferences/preferences_helper.dart';

class AppProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  AppProvider({required this.preferencesHelper}) {
    _loginStatus();
  }

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> _loginStatus() async {
    final String token = await preferencesHelper.token;

    if (token.isEmpty) {
      _isLoggedIn = false;
    } else {
      _isLoggedIn = true;
    }

    notifyListeners();
  }
}
