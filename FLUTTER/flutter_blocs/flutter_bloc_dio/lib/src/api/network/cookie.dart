// ignore_for_file: constant_identifier_names
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';

// 重写 CookieJar
class CookieJarImpl implements CookieJar {
  static const String _COOKIE_KEY_AUTH = 'ky_auth';
  static const String _COOKIE_KEY_SDK = 'sdk';

  @override
  Future<List<Cookie>> loadForRequest(Uri uri) {
    List<Cookie> cookies = [];
    var cookie1 = Cookie(_COOKIE_KEY_SDK, '28')..domain = uri.host;
    cookies.add(cookie1);
    var cookie2 = Cookie(_COOKIE_KEY_AUTH, getCookieValue())..domain = uri.host;
    cookies.add(cookie2);
    return Future(() => cookies);
  }

  @override
  Future<void> saveFromResponse(Uri uri, List<Cookie> cookies) async {
    Cookie cookieValue =
        cookies.singleWhere((element) => element.name == _COOKIE_KEY_AUTH);
    
      saveCookieValue(cookieValue.value);
    
  }

  void saveCookieValue(String value) {
    //save cookie into sp

  }

  String getCookieValue() {
    //get cookie from sp
    return "";
  }

  @override
  bool get ignoreExpires => false;
  
  @override
  Future<void> delete(Uri uri, [bool withDomainSharedCookie = false]) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }
}
