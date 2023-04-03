import 'package:flutter/material.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/api/requests/register_request.dart';
import 'package:storitter/data/result_state.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiServices apiServices;

  RegisterProvider({required this.apiServices});

  late ResultState _state;
  late String _message;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> registerUser(RegisterRequest body) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiServices.registerUser(body);

      if (response.error) {
        throw Exception(response.error);
      }

      _state = ResultState.success;
      notifyListeners();
      return _message = response.message;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: ($e)';
    }
  }
}
