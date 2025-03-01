import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:words/native/native_main.dart';

class YRequest {
  // static final String url = "https://fulitu.neocities.org";
  static final String url = "https://www.fulitu.cc/";
  static final String urlServer =
      "https://fc-mp-00fbb6fa-0b8f-41d8-ac0c-122a477de70e.next.bspapp.com/words";
  late String? url_;
  YRequest({this.url_});
  Future get() async {
    late Uri uri;
    uri = Uri.parse(url_ ?? url);
    var res = await http.get(uri);
    if (res.statusCode == 200) {
      String htmlbody = utf8.decode(res.bodyBytes);
      return htmlbody;
    } else {
      return "null";
    }
  }

  //价格列表
  static Future<List<Price>?> getPrice() async {
    final Uri url = Uri.parse("$urlServer/price");
    var res = await http.get(url);
    if (res.statusCode == 200) {
      String body = utf8.decode(res.bodyBytes);
      List<dynamic> jsonList = jsonDecode(body);
      List<Price> prices =
          jsonList.map((json) => Price.fromJson(json)).toList();
      return prices;
    }
    return null;
    // return utf8.decode(res.bodyBytes);
  }

  //激活
  static Future<ActiveRes> active(String key) async {
    final Uri url = Uri.parse("$urlServer/active?key=$key");
    var res = await http.get(url, headers: {"deviceId": await NativeMain.uuid});
    if (res.statusCode == 200) {
      Map<String, dynamic> jsonMap = jsonDecode(utf8.decode(res.bodyBytes));
      return ActiveRes(code: jsonMap['code'], msg: jsonMap['msg']);
    }
    return ActiveRes(code: 0, msg: "激活错误");
  }

  //检测激活
  static Future<ActiveState?> isactive() async {
    final Uri url = Uri.parse("$urlServer/isactive");
    var res = await http.get(url, headers: {"deviceId": await NativeMain.uuid});
    if (res.statusCode == 200) {
      if (res.body != '') {
        Map<String, dynamic> data = jsonDecode(res.body);
        return ActiveState(
          key: data['key'],
          keyType: int.parse(data['keyType']),
          activeTime: data['activeTime'],
        );
      }
    }
    return null;
  }
}

//激活状态
class ActiveState {
  final String key;
  final int keyType;
  final int activeTime;
  ActiveState(
      {required this.key, required this.keyType, required this.activeTime});
  factory ActiveState.fromJson(Map<String, dynamic> json) {
    return ActiveState(
      key: json['key'],
      keyType: json['keyType'],
      activeTime: json['activeTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'key': key, 'keyType': keyType, 'activeTime': activeTime};
  }
}

//激活
class ActiveRes {
  final int code;
  final String msg;
  ActiveRes({required this.code, required this.msg});
}

//价格
class Price {
  final String price;
  final String label1;
  final String label2;

  Price({required this.price, required this.label1, required this.label2});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      price: json['price'],
      label1: json['label1'],
      label2: json['label2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'label1': label1,
      'label2': label2,
    };
  }
}
