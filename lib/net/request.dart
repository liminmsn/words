import 'dart:convert';

import 'package:http/http.dart' as http;

class YRequest {
  // static final String url = "https://fulitu.neocities.org";
  static final String url = "https://www.fulitu.cc/";
  static final String url_server =
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

  static Future<List<Price>?> getPrice() async {
    final Uri url = Uri.parse("$url_server/price");
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
}

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
}
