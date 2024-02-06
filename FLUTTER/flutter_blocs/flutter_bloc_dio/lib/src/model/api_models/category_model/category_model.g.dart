// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      json['name'] as String,
      List.fromJson(json['list'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'list': instance.list,
    };

List _$ListFromJson(Map<String, dynamic> json) => List(
      json['name'] as String,
      json['ID'] as int,
      json['city'] as String,
    );

Map<String, dynamic> _$ListToJson(List instance) => <String, dynamic>{
      'name': instance.name,
      'ID': instance.iD,
      'city': instance.city,
    };
