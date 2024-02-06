import 'package:json_annotation/json_annotation.dart';

part 'base_res.g.dart';

@JsonSerializable()
class BaseRes extends Object {
  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'err_msg')
  String errMsg;

  @JsonKey(name: 'code')
  String code;

  BaseRes(
    this.data,
    this.errMsg,
    this.code,
  );

  factory BaseRes.fromJson(Map<String, dynamic> srcJson) =>
      _$BaseResFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BaseResToJson(this);
}

@JsonSerializable()
class Data extends Object {
  Data();

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
