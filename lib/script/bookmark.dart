import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:words/api/api_photo.dart';

class Bookmark {
  static isExist_(List<YImg> list, YImg item) {
    return list.any((element) => element.url == item.url);
  }

  static data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('bookmark') == null) {
      prefs.setString('bookmark', jsonEncode([]));
      return [];
    } else {
      List<YImg> list =
          (jsonDecode(prefs.getString('bookmark')!) as List<dynamic>)
              .map((e) => YImg.fromJson(e))
              .toList();
      return list;
    }
  }

  static setData(List<YImg> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 将 YImg 对象转换为 JSON 格式
    List<Map<String, dynamic>> jsonYImgList =
        list.map((yImg) => yImg.toJson()).toList();
    prefs.setString('bookmark', jsonEncode(jsonYImgList));
  }

  static add(YImg item) async {
    List<YImg> list = await data();
    list.add(item);
    setData(list);
  }

  static del(YImg item) async {
    List<YImg> list = await data();
    list.removeWhere((element) => element.url == item.url);
    setData(list);
  }

  static isExist(YImg item) async {
    List<YImg> list = await data();
    return list.any((element) => element.url == item.url);
  }
}
