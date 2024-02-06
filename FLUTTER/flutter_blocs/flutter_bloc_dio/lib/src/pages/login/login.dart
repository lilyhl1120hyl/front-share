import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc_dio/src/bloc/login/login_bloc.dart';
import 'package:flutter_bloc_dio/src/api/repository/authentication_repository.dart';

import 'package:flutter_bloc_dio/src/pages/login/loginPages/userCodeLogin/user_code.dart';
import 'package:flutter_bloc_dio/src/pages/login/loginPages/userPasswordLogin/user_password.dart';
import 'package:flutter_bloc_dio/src/pages/login/loginPages/phoneLogin/phone_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authenticationRepository,
        child: BlocProvider(
            create: (_) => LoginBloc(
                  authenticationRepository: _authenticationRepository,
                ),
            child: DefaultTabController(
              initialIndex: 1,
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('登录'),
                  bottom: const TabBar(
                    tabs: <Widget>[
                      Tab(text: '账号密码登录'),
                      Tab(text: '验证码登录'),
                      Tab(text: 'SIM快捷登录'),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: <Widget>[
                    UserPasswordLogin(),
                    UserCode(),
                    PhoneLogin(),
                  ],
                ),
              ),
            )));
  }
}
