import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:words/api/api_photo.dart';
import 'package:words/api/api_proto_detail.dart';
import 'package:words/net/request.dart';

class DetailHome extends StatefulWidget {
  final YImg item;
  const DetailHome({super.key, required this.item});

  @override
  State<DetailHome> createState() => _DetailHomeState();
}

class _DetailHomeState extends State<DetailHome> {
  List<YImgDetail> imgs = [];
  @override
  void initState() {
    super.initState();
    YRequest(url_: widget.item.url).get((r) {
      setState(() {
        imgs = ApiProtoDetail(r).imgs;
      });
    });
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
          return SimpleDialog(
            // title: Container(
            //   padding: EdgeInsets.all(0),
            //   child: ,
            // ),
            children: <Widget>[
              Column(
                children: [
                  Text(y.title),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.network(y.src),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // 按钮点击事件
                      },
                      child: Row(
                        children: [
                          Text('Save'),
                          Icon(Icons.download),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.alt),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            for (var i = 0; i < imgs.length; i++)
              GestureDetector(
                onTap: () => onTap(imgs[i]),
                child: Image.network(imgs[i].src),
              ),
          ],
        ),
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
