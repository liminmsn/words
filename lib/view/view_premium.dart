import 'package:flutter/material.dart';

class ViewPremium extends StatefulWidget {
  const ViewPremium({super.key});

  @override
  State<ViewPremium> createState() => _ViewPremiumState();
}

class _ViewPremiumState extends State<ViewPremium> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(), // 设置回弹效果
              itemCount: 4,
              itemBuilder: (context, index) {
                return YCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class YCard extends StatelessWidget {
  const YCard({super.key});

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
                        "¥6.00",
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
                            size: 30,
                            color: labelColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "写真滚动预览",
                            style: TextStyle(
                              color: labelColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 30,
                            color: labelColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "收藏无水印滚动预览",
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
                    "点击二维码微信获取赏码\n赞赏获取激活码",
                    style: TextStyle(fontSize: 8, color: Colors.white),
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
