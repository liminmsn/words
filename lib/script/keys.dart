import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:words/net/request.dart';

class Keys {
  static ActiveState? activeState;
  late SharedPreferences _prefs;
  Future<ActiveState?> data() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('key') == null) {
      //重置激活
      var res = await YRequest.isactive();
      if (res == null) return null;
      //激活存本地
      _prefs.setString('key', jsonEncode(res));
    }
    return ActiveState.fromJson(jsonDecode(_prefs.getString('key')!));
  }

  Future<String> getOutTime() async {
    var data_ = await data();
    if (data_ == null) return "激活码已经过期";

    //累加keytype天
    DateTime outTime = DateTime.fromMillisecondsSinceEpoch(data_.activeTime);
    outTime = outTime.add(Duration(days: fromDay(data_.keyType)));

    //过期时间
    int timestamp1 = outTime.millisecondsSinceEpoch; // 第一个时间戳（毫秒）
    //当下时间
    int timestamp2 = DateTime.now().millisecondsSinceEpoch; // 第二个时间戳（毫秒）

    DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(timestamp1);
    DateTime dateTime2 = DateTime.fromMillisecondsSinceEpoch(timestamp2);
    Duration difference = dateTime1.difference(dateTime2);

    return '剩余时间：${difference.inDays} 天 ${difference.inHours.remainder(24)} 小时 ${difference.inMinutes.remainder(60)} 分钟';
  }

  int fromDay(int val) {
    if (val == 0) return 1;
    if (val == 1) return 3;
    if (val == 2) return 5;
    return 0;
  }

  //删除本地缓存
  static reset() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('key');
    // await Keys().init();
  }
}
