import 'package:storitter/data/model/story.dart';

class GetDetailStoriesResponse {
  GetDetailStoriesResponse({
    required this.error,
    required this.message,
    required this.story,
  });

  final bool error;
  final String message;
  final Story story;

  factory GetDetailStoriesResponse.fromJson(Map<String, dynamic> json) => GetDetailStoriesResponse(
    error: json["error"],
    message: json["message"],
    story: Story.fromJson(json["story"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "story": story.toJson(),
  };
}