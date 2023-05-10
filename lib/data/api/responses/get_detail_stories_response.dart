import 'package:json_annotation/json_annotation.dart';
import 'package:storitter/data/model/story.dart';

part 'get_detail_stories_response.g.dart';

@JsonSerializable()
class GetDetailStoriesResponse {
  GetDetailStoriesResponse({
    required this.error,
    required this.message,
    required this.story,
  });

  final bool error;
  final String message;
  final Story story;

  factory GetDetailStoriesResponse.fromJson(Map<String, dynamic> json) => _$GetDetailStoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDetailStoriesResponseToJson(this);
}