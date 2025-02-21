import 'package:flutter/services.dart';
import 'package:words/native/native_main.dart';

class NativeOn {
  static const platform = NativeMain.platform;
  static void onTackScene() {
    // 监听来自 Android 的调用
    platform.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'tackScene') {
        return 'Result from Dart';
      }
    });
  }
}
