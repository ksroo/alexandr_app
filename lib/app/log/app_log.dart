import 'package:flutter/material.dart';

class AppLog {
  AppLog._();
  static log(dynamic msg, {bool isDebug = true}) {
    if (isDebug) {
      debugPrint(msg);
    } else {
      debugPrint(msg);
    }
  }
}
