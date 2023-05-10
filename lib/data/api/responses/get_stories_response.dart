import 'package:json_annotation/json_annotation.dart';
import 'package:storitter/data/model/story.dart';

part 'get_stories_response.g.dart';

@JsonSerializable()
class GetStoriesResponse {
  GetStoriesResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  final bool error;
  final String message;
  final List<Story> listStory;

  factory GetStoriesResponse.fromJson(Map<String, dynamic> json) => _$GetStoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetStoriesResponseToJson(this);
}
