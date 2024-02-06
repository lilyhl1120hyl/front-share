import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_dio/src/model/common_models/user_model/user_info.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc_dio/src/config/common_config.dart';
import 'package:uuid/uuid.dart';

enum Env {
  pro,
  sit,
  uat,
  dev,
}

class Global {
  static late SharedPreferences prefs;
  static late Logger logger;
  static late UserInfo userProfile;
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");
  static const int appVersion = 5;
  static late String advertisingId;
  static final navKey = GlobalKey<NavigatorState>();

  /// 设置App版本号
  static Env env = isRelease ? Env.pro : Env.sit;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    prefs = await SharedPreferences.getInstance();
    _initComponent();
    _initCacheAndConfigure();
  }

  static void _initComponent() {
    try {
      _loggerInit();
    } catch (e) {
      log("Component initial error: $e");
    }
  }

  static void _initCacheAndConfigure() {
    try {
      final appEnv = prefs.getString(CacheKey.appEnv);
      if (appEnv != null && !isRelease) {
        switch (appEnv) {
          case "SIT":
            env = Env.sit;
            break;
          case "DEV":
            env = Env.dev;
            break;
          case "PRO":
            env = Env.pro;
            break;
        }
      }
      final ad = prefs.getString(CacheKey.advertisingId);
      if (ad != null) {
        advertisingId = ad;
      } else {
        advertisingId = const Uuid().v4();
        prefs.setString(CacheKey.advertisingId, advertisingId);
      }

      final profile = prefs.getString(CacheKey.userProfile);
      if (profile != null) {
        userProfile = UserInfo.fromJson(jsonDecode(profile));
      } else {
        userProfile = UserInfo.anonymous();
      }
    } catch (e) {
      logger.e("Configure initial error: $e");
    }
  }

  static void _loggerInit() {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 1,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: false,
      ),
      output: ConsoleOutput(),
    );
  }

  // 持久化Profile信息
  static saveAppEnv(String env) => prefs.setString(CacheKey.appEnv, env);

  // 持久化Profile信息
  static saveProfile() =>
      prefs.setString(CacheKey.userProfile, jsonEncode(userProfile));
}

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(printWrapped);
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  // This works too.
  void printWrapped2(String text) => debugPrint(text, wrapWidth: 1024);
  void printWrapped3(String text) => log(text);
}
