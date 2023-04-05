import 'package:flutter/material.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/api/requests/login_request.dart';
import 'package:storitter/data/api/responses/login_response.dart';
import 'package:storitter/data/preferences/preferences_helper.dart';
import 'package:storitter/data/result_state.dart';

class LoginProvider extends ChangeNotifier {
  final ApiServices apiServices;
  final PreferencesHelper preferencesHelper;

  LoginProvider({required this.apiServices, required this.preferencesHelper});

  late LoginResult _user;
  late ResultState _state;
  late String _message;

  LoginResult get user => _user;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> loginUser(LoginRequest body) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiServices.loginUser(body);

      if (response.error) {
        throw Exception(response.error);
      }

      _state = ResultState.success;
      notifyListeners();

      preferencesHelper.saveToken(response.loginResult.token);

      return _message = "Login Succeeded";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: ($e)';
    }
  }
}
