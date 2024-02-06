import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc_dio/src/app.dart';
import 'package:flutter_bloc_dio/src/config/common_style.dart';
// 路由配置
import 'package:flutter_bloc_dio/src/routers/application.dart';
import 'package:flutter_bloc_dio/src/routers/routes.dart';

void main() {
  // 声明路由
  final router = FluroRouter();
  Application.router = router;
  Routes.configureRoutes(router);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //取消debug图标
      title: 'Flutter Bloc',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBgColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(backgroundColor: kPrimaryColor),
        ),
      ),
      //路由全局注册
      onGenerateRoute: Application.router.generator,
      home: const App(),
    );
  }
}
