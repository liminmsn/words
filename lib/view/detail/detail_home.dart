import 'package:flutter/material.dart';
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
    final ScrollController _scrollController = ScrollController();

    void _scrollToTop() {
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.alt),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            for (var i = 0; i < imgs.length; i++) Image.network(imgs[i].src)
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _scrollToTop,
            child: Icon(Icons.expand_less),
          ),
        ],
      ),
    );
  }
}
