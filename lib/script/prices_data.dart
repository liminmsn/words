import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:words/net/request.dart';

class PricesData {
  late SharedPreferences _prices;
  init() async {
    _prices = await SharedPreferences.getInstance();
  }

  clear() async {
    await init();
    _prices.remove('_prices');
  }

  set(List<Price> prices) async {
    await init();
    _prices.remove('_prices');
    List<String> prices_ = prices.map((item) {
      return jsonEncode(item);
    }).toList();
    _prices.setStringList("_prices", prices_);
  }

  Future<List<Price>> get() async {
    await init();
    var prices = _prices.getStringList('_prices');
    List<Price> prices_ = [];
    if (prices != null && prices.isNotEmpty) {
      prices_ = prices.map((item) {
        Map<String, dynamic> price = jsonDecode(item);
        return Price(
            price: price['price'],
            label1: price['label1'],
            label2: price['label2']);
      }).toList();
      return prices_;
    }
    return [];
  }
}
