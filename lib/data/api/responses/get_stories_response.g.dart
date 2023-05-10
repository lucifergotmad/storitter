// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_stories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStoriesResponse _$GetStoriesResponseFromJson(Map<String, dynamic> json) =>
    GetStoriesResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>)
          .map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetStoriesResponseToJson(GetStoriesResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
