import 'package:json_annotation/json_annotation.dart'; 
  
part 'category_model.g.dart';


@JsonSerializable()
  class CategoryModel extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'list')
  List<List> list;

  CategoryModel(this.name,this.list,);

  factory CategoryModel.fromJson(Map<String, dynamic> srcJson) => _$CategoryModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

}

  
@JsonSerializable()
  class List extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'ID')
  int iD;

  @JsonKey(name: 'city')
  String city;

  List(this.name,this.iD,this.city,);

  factory List.fromJson(Map<String, dynamic> srcJson) => _$ListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ListToJson(this);

}

  
