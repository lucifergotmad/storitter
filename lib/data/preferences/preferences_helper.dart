import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const tokenKey = "ACCESS_TOKEN_KEY";

  Future<String> get token async {
    final prefs = await sharedPreferences;
    return prefs.getString(tokenKey) ?? "";
  }

  void saveToken(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(tokenKey, value);
  }

  void removeToken() async {
    final prefs = await sharedPreferences;
    prefs.remove(tokenKey);
  }
}
