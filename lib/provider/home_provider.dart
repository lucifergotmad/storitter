import 'package:flutter/cupertino.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/model/story.dart';
import 'package:storitter/data/result_state.dart';

class HomeProvider extends ChangeNotifier {
  final ApiServices apiServices;

  HomeProvider({required this.apiServices});

  ResultState _state = ResultState.idle;

  ResultState get state => _state;

  late List<Story> _listStory;

  List<Story> get listStory => _listStory;

  String _message = "";

  String get message => _message;

  Future<void> fetchAllStory(String token) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiServices.getStories(token);
      print("isFetched");
      if (response.listStory.isEmpty) {
        _state = ResultState.noData;
        _message = "Data not found!";
      } else {
        _state = ResultState.hasData;
        _listStory = response.listStory;
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: ($e)';
      notifyListeners();
    }
  }
}
