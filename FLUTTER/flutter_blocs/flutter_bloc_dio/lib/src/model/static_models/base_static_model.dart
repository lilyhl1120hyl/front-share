@JsonSerializable()
class BaseRes<T> {
  BaseRes(this.msg, this.code, this.data);

  late String msg;
  late int code;
  late T data;

  BaseRes.fromJson(Map<String, dynamic>? json) {
    if (json?['data'] != null && json?['data'] != 'null') {
      data = JsonConvert.fromJsonAsT<T>(json?['data']) as T;
    }
    msg = json?['msg'];
    code = json?['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}
