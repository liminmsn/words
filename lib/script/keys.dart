import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:words/net/request.dart';

class Keys {
  late SharedPreferences _prefs;
  Keys() {
    init();
  }
  Future<ActiveState> init() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('key') == null) {
      var res = await YRequest.isactive();
      _prefs.setString('key', jsonEncode(res));
    }
    var obj = ActiveState.fromJson(jsonDecode(_prefs.getString('key')!));
    return obj;
  }

  //检查激活装
  Future<bool> isActive() async {
    var res = await init();

    return false;
  }
}
