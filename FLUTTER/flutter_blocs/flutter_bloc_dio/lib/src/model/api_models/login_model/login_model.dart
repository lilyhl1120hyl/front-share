import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends Object {
  @JsonKey(name: 'err_code')
  int errCode;

  @JsonKey(name: 'err_msg')
  String errMsg;

  @JsonKey(name: 'uuid')
  String uuid;

  @JsonKey(name: 'token')
  String token;

  LoginModel(
    this.errCode,
    this.errMsg,
    this.uuid,
    this.token,
  );

  factory LoginModel.fromJson(Map<String, dynamic> srcJson) =>
      _$LoginModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
