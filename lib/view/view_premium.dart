import 'package:flutter/material.dart';
import 'package:words/components/y_loding.dart';
import 'package:words/native/native_main.dart';
import 'package:words/net/request.dart';

class ViewPremium extends StatefulWidget {
  const ViewPremium({super.key});

  @override
  State<ViewPremium> createState() => _ViewPremiumState();
}

class _ViewPremiumState extends State<ViewPremium> {
  late bool show = false;
  late List<Price> prices = [];
  late String activeIpt = "1";

  Future<List<Price>> fetchData() async {
    activeIpt = await NativeMain.uuid;
    setState(() {
      activeIpt = activeIpt;
    });
    var res = await YRequest.getPrice();
    if (res != null) {
      setState(() {
        prices = res;
      });
      return res;
    } else {
      return [];
    }
  }

  //激活
  void activeCode() {}

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  color: Theme.of(context).colorScheme.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Premium Time",
                        style: TextStyle(
                            // fontSize: 20,
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "00:00:00",
                            style: TextStyle(
                                fontSize: 60,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                          ),
                        ),
                      ),
                      Text(
                        "设备ID",
                        style: TextStyle(
                            fontSize: 14,
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                      ),
                      SizedBox(
                        height: 30,
                        child: Text(
                          activeIpt,
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              // color: Theme.of(context).colorScheme.onPrimaryContainer,
              padding: EdgeInsets.only(top: 2, bottom: 0),
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    "暂时没有接入合适的第三方支付，请到微信公众号关注获取订阅 ",
                    style: TextStyle(
                        fontSize: 8,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 2),
            SizedBox(
              height: 200,
              child: prices.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(), // 设置回弹效果
                      itemCount: prices.length,
                      itemBuilder: (context, index) {
                        return YCard(
                          price: prices[index],
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_download_outlined),
                          Text("Loding..."),
                        ],
                      ),
                    ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      // obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Active Code'),
                      onChanged: (value) => activeIpt = value,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Active"),
            ),
          ],
        ),
      ),
    );
  }
}

//vip卡片
class YCard extends StatelessWidget {
  final Price price;
  const YCard({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    Color labelColor = Theme.of(context).colorScheme.primaryContainer;
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).colorScheme.primary,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        price.price,
                        style: TextStyle(
                          color: labelColor,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 25,
                            color: labelColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            price.label1,
                            style: TextStyle(
                              color: labelColor,
                              fontWeight: FontWeight.bold,
                              // fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 25,
                            color: labelColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            price.label2,
                            style: TextStyle(
                              color: labelColor,
                              // fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: -40,
              right: -40,
              child: Icon(
                Icons.circle,
                size: 100,
                color: labelColor,
              ),
            ),
            Positioned(
              left: -40,
              bottom: -40,
              child: Icon(
                Icons.circle,
                size: 100,
                color: labelColor,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Row(
                children: [
                  Text(
                    "点击二维码复制\n微信公众号:Alluring",
                    style: TextStyle(fontSize: 8, color: labelColor),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.qr_code,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//弹窗
