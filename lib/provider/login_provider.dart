import 'package:flutter/material.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/api/requests/login_request.dart';
import 'package:storitter/data/model/user.dart';
import 'package:storitter/data/result_state.dart';

class LoginProvider extends ChangeNotifier {
  final ApiServices apiServices;

  LoginProvider({required this.apiServices});

  late User _user;
  ResultState _state = ResultState.idle;
  late String _message;

  User get user => _user;

  ResultState get state => _state;

  String get message => _message;

  Future<User?> loginUser(LoginRequest body) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiServices.loginUser(body);

      if (response.error) {
        throw Exception(response.error);
      }

      _state = ResultState.success;
      notifyListeners();

      return _user = response.loginResult;
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: ($e)';
      notifyListeners();
      return null;
    }
  }
}
