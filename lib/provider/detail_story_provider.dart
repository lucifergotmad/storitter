import 'package:flutter/cupertino.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/model/story.dart';
import 'package:storitter/data/result_state.dart';

class DetailStoryProvider extends ChangeNotifier {
  final ApiServices apiServices;

  DetailStoryProvider({required this.apiServices});

  late Story _story;

  Story get story => _story;

  ResultState _state = ResultState.idle;

  ResultState get state => _state;

  String _message = "";

  String get message => _message;

  Future<void> fetchDetailStories(String token, String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiServices.getDetailStories(token, id);
      if (response.error) {
        _state = ResultState.noData;
        _message = "No data found";
      } else {
        _state = ResultState.hasData;
        _story = response.story;
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: ($e)';
      notifyListeners();
    }
  }
}
