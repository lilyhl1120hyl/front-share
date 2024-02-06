import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///错误提示样式的toast
void showWarnToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white);
}

///普通提示样式的toast
void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
  );
}

///成功提示样式的toast
void showSuccessToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white);
}
