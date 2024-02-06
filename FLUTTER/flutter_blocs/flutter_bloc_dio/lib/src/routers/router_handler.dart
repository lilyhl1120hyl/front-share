
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
// 引入页面
import 'package:flutter_bloc_dio/src/pages/detail/detail.dart';
import 'package:flutter_bloc_dio/src/pages/home/home.dart';
import 'package:flutter_bloc_dio/src/pages/login/login.dart';

var detailHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    final args = params['id']!.first; //接收传的参数
    return DetailPage(id: args);
  }
);

var homeHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return const HomePage();
  }
);


var loginHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return const LoginPage();
  }
);