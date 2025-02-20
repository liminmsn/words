import 'package:flutter/services.dart';

class NativeMain {
  static const platform = MethodChannel('com.example.words.native/uuid');

  static Future<String> get uuid async {
    final String version = await platform.invokeMethod('uuid');
    return version;
  }
}
