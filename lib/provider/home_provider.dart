import 'package:flutter/cupertino.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/model/story.dart';
import 'package:storitter/data/result_state.dart';

class HomeProvider extends ChangeNotifier {
  final ApiServices apiServices;

  HomeProvider({required this.apiServices});

  ResultState _state = ResultState.idle;

  ResultState get state => _state;

  final List<Story> _listStory = [];

  List<Story> get listStory => _listStory;

  String _message = "";

  String get message => _message;

  int? pageItems = 1;

  int sizeItems = 10;

  Future<bool> fetchAllStory(String token, bool upload) async {
    try {
      if (pageItems == 1) {
        _state = ResultState.loading;
        notifyListeners();
      }

      if (upload) {
        pageItems = 1;
      }

      final response =
          await apiServices.getStories(token, pageItems!, sizeItems);

      if (response.listStory.isEmpty) {
        _state = ResultState.noData;
        _message = "Data not found!";
      } else {
        _state = ResultState.hasData;

        if (upload) {
          _listStory.clear();
        }

        _listStory.addAll(response.listStory);
      }

      if (response.listStory.length < sizeItems) {
        pageItems = null;
      } else {
        pageItems = pageItems! + 1;
      }

      notifyListeners();
      return true;
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: ($e)';
      notifyListeners();
      return false;
    }
  }
}
