import 'package:shared_preferences/shared_preferences.dart';
import 'package:words/net/request.dart';

class Keys {
  late SharedPreferences _prefs;
  Keys() {
    init();
  }
  init() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.getString("key") ?? _prefs.setString("key", "");
    _prefs.getString("keyType") ?? _prefs.setString("keyType", "");
    _prefs.getString("time") ?? _prefs.setString("time", "-1");
  }

  Future isActive() async {
    var res = await YRequest.isactive();
    return res;
  }

  //添加
  add(String key, String keyType, int time) {
    _prefs.setString("key", key);
    _prefs.setString("keyType", keyType);
    _prefs.setInt("time", time);
  }

  //清空
  clear() {
    _prefs.remove("key");
    _prefs.remove("keyType");
    _prefs.remove("time");
  }

  get key {
    return _prefs.getString("key");
  }

  get keyType {
    return _prefs.getInt("keyType");
  }

  get time {
    return _prefs.getString("time");
  }
}
