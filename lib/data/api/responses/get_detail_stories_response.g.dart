// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_detail_stories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDetailStoriesResponse _$GetDetailStoriesResponseFromJson(
        Map<String, dynamic> json) =>
    GetDetailStoriesResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      story: Story.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDetailStoriesResponseToJson(
        GetDetailStoriesResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };
