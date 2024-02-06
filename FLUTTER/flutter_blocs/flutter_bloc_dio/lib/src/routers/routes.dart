import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc_dio/src/pages/notFound/notFound.dart';
import 'package:flutter_bloc_dio/src/routers/router_handler.dart';

class Routes {

  static String detail = "/detail";  //定义路由
  static String login = '/login'; 
  static String home = '/home'; 

  static void configureRoutes(FluroRouter router) { //处理未匹配到路由时展示的页面
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const NotFoundPage();
      });
      //注册路由并指向所对应的handler(Handler对应的是界面)
    router.define(detail, handler: detailHandler);
    router.define(login, handler: loginHandler);
    router.define(home, handler: homeHandler);
  }
}
