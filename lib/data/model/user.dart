import "package:json_annotation/json_annotation.dart";

part "user.g.dart";

@JsonSerializable()
class User {
  User({
    required this.userId,
    required this.name,
    required this.token,
  });

  final String userId;
  final String name;
  final String token;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
