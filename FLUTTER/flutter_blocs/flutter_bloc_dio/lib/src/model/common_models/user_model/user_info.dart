import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  String userId;
  String enterpriseNo;
  String username;
  String? name;
  String? token;

  UserInfo(
      {this.name,
      required this.userId,
      this.token,
      this.enterpriseNo = "",
      this.username = ""});

  /// Connect the generated [_$UserInfoFromJson] function to the `fromJson`
  /// factory.
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  /// Connect the generated [_$UserInfoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  static UserInfo anonymous() => UserInfo(userId: const Uuid().v4());
}
