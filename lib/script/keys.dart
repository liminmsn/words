import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:words/net/request.dart';

class Keys {
  late SharedPreferences _prefs;
  Future<ActiveState?> data() async {
    _prefs = await SharedPreferences.getInstance();
    //本地没有存储
    if (_prefs.getString('key') == null) {
      var res = await YRequest.isactive();
      //请求为空，没有激活
      if (res != null) {
        _prefs.setString('key', jsonEncode(res));
      } else {
        return null;
      }
    }
    return ActiveState.fromJson(jsonDecode(_prefs.getString('key')!));
  }

  //检查激活装
  Future<bool> isActive() async {
    var res = await data();
    if (res == null) {
      return false;
    }
    return true;
  }
}
