import 'package:flutter/material.dart';
import 'package:words/api/api_photo.dart';
import 'package:words/api/api_proto_detail.dart';
import 'package:words/components/y_loding.dart';
import 'package:words/net/request.dart';

class DetailHome extends StatefulWidget {
  final YImg item;
  const DetailHome({super.key, required this.item});

  @override
  State<DetailHome> createState() => _DetailHomeState();
}

class _DetailHomeState extends State<DetailHome> {
  Future<List<YImgDetail>> fetchData() async {
    var body = await YRequest(url_: widget.item.url).get();
    return ApiProtoDetail(body).imgs;
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    void scrollToTop() {
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    void onTap(YImgDetail y) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    y.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Image.network(y.src),
                  // Text('This is a custom dialog example.'),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // 按钮点击事件
                        },
                        child: Row(
                          children: [Text('Save'), Icon(Icons.download)],
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [Text('Close'), Icon(Icons.close)],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.alt),
      ),
      body: Yloding.buildr(
        future: fetchData,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                for (var i = 0; i < snapshot.data!.length; i++)
                  GestureDetector(
                    onTap: () => onTap(snapshot.data![i]),
                    child: Image.network(snapshot.data![i].src),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: scrollToTop,
            child: Icon(Icons.expand_less),
          ),
        ],
      ),
    );
  }
}
