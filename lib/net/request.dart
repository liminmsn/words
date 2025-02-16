import 'dart:convert';

import 'package:http/http.dart' as http;

typedef RequCall = void Function(String dom);

class YRequest {
  // static final String url = "https://fulitu.neocities.org";
  static final String url = "https://www.fulitu.cc/";
  late String urla = url;
  String? urlb;
  YRequest([this.urlb]) : urla = url + (urlb ?? '');
  void get(RequCall r) async {
    late Uri uri = Uri.parse(urla);
    var res = await http.get(uri);
    if (res.statusCode == 200) {
      String htmlbody = utf8.decode(res.bodyBytes);
      r.call(htmlbody);
    } else {
      r.call("null");
    }
  }
}
