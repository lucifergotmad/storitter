import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final SharedPreferences sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const tokenKey = "ACCESS_TOKEN_KEY";

  String get token {
    final prefs = sharedPreferences;
    return prefs.getString(tokenKey) ?? "";
  }

  void saveToken(String value) {
    final prefs = sharedPreferences;
    prefs.setString(tokenKey, value);
  }

  void removeToken() {
    final prefs = sharedPreferences;
    prefs.remove(tokenKey);
  }
}
