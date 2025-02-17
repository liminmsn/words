import 'dart:convert';

import 'package:http/http.dart' as http;

class YRequest {
  // static final String url = "https://fulitu.neocities.org";
  static final String url = "https://www.fulitu.cc/";
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
}
