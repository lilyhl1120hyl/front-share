import 'dart:async';
import 'package:flutter_bloc_dio/src/api/apis/dio_api.dart';
import 'package:flutter_bloc_dio/src/model/api_models/login_model/login_model.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
    // ignore: non_constant_identifier_names
    required String app_key,
  }) async {
    // await Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );

    final reqData = {
      "username": username,
      "password": password,
      "app_key": app_key
    };

    print('登录接口参数：$reqData');
    var res = await getHttp('api/App/User/Login', reqData);
    if (res?.code == 200 && res?.data != null) {
      print('登录接口2：$res');
    }

    if (res.isNotEmpty) {
      _controller.add(AuthenticationStatus.authenticated);
      return Future.value(LoginModel.fromJson(res));
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
