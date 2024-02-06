// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRes _$BaseResFromJson(Map<String, dynamic> json) => BaseRes(
      Data.fromJson(json['data'] as Map<String, dynamic>),
      json['err_msg'] as String,
      json['code'] as String,
    );

Map<String, dynamic> _$BaseResToJson(BaseRes instance) => <String, dynamic>{
      'data': instance.data,
      'err_msg': instance.errMsg,
      'code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data();

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{};
