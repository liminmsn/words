import 'dart:async';

import 'package:flutter/material.dart';
import 'package:words/native/native_main.dart';
import 'package:words/net/request.dart';
import 'package:words/script/keys.dart';
import 'package:words/script/prices_data.dart';

class ViewPremium extends StatefulWidget {
  const ViewPremium({super.key});

  @override
  State<ViewPremium> createState() => _ViewPremiumState();
}

class _ViewPremiumState extends State<ViewPremium>
    with SingleTickerProviderStateMixin {
  late bool show = false;
  late List<Price> prices = [];
  late String activeIpt = "MTc0MDM4NTQ1NTMxMQ==";
  late String mobeid = "";
  late ActiveState activeState =
      ActiveState(key: '', keyType: -1, activeTime: 0);

  late AnimationController _controller;
  late Animation<double> _animation;

  Future<List<Price>> fetchData() async {
    mobeid = await NativeMain.uuid;
    setState(() => mobeid = mobeid);

    Keys().data().then((val) {
      setState(() => activeState = val!);
    });

    var res_ = await PricesData().get();

    //如果本地已经缓存了数据（节流）
    if (res_.isNotEmpty) {
      setState(() => prices = res_);
      return res_;
      //从网络请求一次
    } else {
      var res = await YRequest.getPrice();
      if (res != null) {
        await PricesData().set(res);
        setState(() => prices = res);
        return res;
      } else {
        return [];
      }
    }
  }

  //激活
  void activeCode() {
    _controller.forward();
    late List<Widget> icon = [
      RotationTransition(
        turns: _animation,
        child: Icon(Icons.sync,
            size: 40, color: Theme.of(context).colorScheme.primary),
      ),
      Text("激活中"),
    ];
    late void Function(void Function()) setState_;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            setState_ = setState;
            return SimpleDialog(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 40, bottom: 40),
                  child: Column(children: icon),
                ),
              ],
            );
          },
        );
      },
    );
    YRequest.active(activeIpt).then((res) {
      if (!mounted) return;
      setState_(() {
        if (res.code == 0) {
          Keys().isActive();
          icon = [
            Icon(Icons.cancel,
                size: 40, color: Theme.of(context).colorScheme.error),
            Text(res.msg)
          ];
        }
        if (res.code == 1) {
          icon = [
            Icon(Icons.check_circle, size: 40, color: Colors.lightGreen),
            Text(res.msg)
          ];
        }
      });
    });
  }

  String keyTypeToS(int val) {
    if (val == 0) return "1day";
    if (val == 1) return "3day";
    if (val == 2) return "7day";
    return "--";
  }

  @override
  void initState() {
    super.initState();
    fetchData();

    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 2 * 3.14159).animate(_controller)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.repeat();
          }
        },
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                      Text(
                        keyTypeToS(activeState.keyType),
                        style: TextStyle(
                            // fontSize: 20,
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            (DateTime.now().millisecondsSinceEpoch - activeState.activeTime).toString(),
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
                          mobeid,
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
                          Icon(
                            Icons.cloud_download_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            "Loding...",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
                          ),
                        ],
                      ),
                    ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
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
              onPressed: activeCode,
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
