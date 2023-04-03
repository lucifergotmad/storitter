import 'package:flutter/material.dart';
import 'package:storitter/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper});

  late String _token;

  String get token => _token;

  void getToken() async {
    _token = await preferencesHelper.token;
    notifyListeners();
  }

  void saveToken(String value) {
    preferencesHelper.saveToken(value);
  }
}
