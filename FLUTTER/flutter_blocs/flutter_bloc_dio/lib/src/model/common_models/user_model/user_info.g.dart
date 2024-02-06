// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      name: json['name'] as String?,
      userId: json['userId'] as String,
      token: json['token'] as String?,
      enterpriseNo: json['enterpriseNo'] as String? ?? "",
      username: json['username'] as String? ?? "",
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'userId': instance.userId,
      'enterpriseNo': instance.enterpriseNo,
      'username': instance.username,
      'name': instance.name,
      'token': instance.token,
    };
