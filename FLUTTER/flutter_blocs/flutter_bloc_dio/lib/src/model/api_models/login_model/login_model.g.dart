// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      json['err_code'] as int,
      json['err_msg'] as String,
      json['uuid'] as String,
      json['token'] as String,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'err_code': instance.errCode,
      'err_msg': instance.errMsg,
      'uuid': instance.uuid,
      'token': instance.token,
    };
