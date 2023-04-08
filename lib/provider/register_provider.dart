import 'package:flutter/material.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/api/requests/register_request.dart';
import 'package:storitter/data/result_state.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiServices apiServices;

  RegisterProvider({required this.apiServices});

  ResultState _state = ResultState.idle;
  late String _message;

  ResultState get state => _state;

  String get message => _message;

  Future<void> registerUser(RegisterRequest body) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiServices.registerUser(body);

      if (response.error) {
        throw Exception(response.error);
      }

      _state = ResultState.success;
      _message = response.message;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: ($e)';
      notifyListeners();
    }
  }
}
