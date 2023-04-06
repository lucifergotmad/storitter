import 'package:storitter/data/model/story.dart';

class GetStoriesResponse {
  GetStoriesResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  final bool error;
  final String message;
  final List<Story> listStory;

  factory GetStoriesResponse.fromJson(Map<String, dynamic> json) => GetStoriesResponse(
    error: json["error"],
    message: json["message"],
    listStory: List<Story>.from(json["listStory"].map((x) => Story.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "listStory": List<dynamic>.from(listStory.map((x) => x.toJson())),
  };
}
