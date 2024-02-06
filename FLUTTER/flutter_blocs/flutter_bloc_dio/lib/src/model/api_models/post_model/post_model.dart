import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';


@JsonSerializable()
class PostModel {
  const PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.imgUrl,
  });

  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  final String title;
  final String imgUrl;

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  String toString() {
    return 'PostModel{id: $id, userId: $userId, title: $title, imgUrl: $imgUrl}';
  }
}
