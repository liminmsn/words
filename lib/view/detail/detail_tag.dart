import 'package:flutter/material.dart';
import 'package:words/api/api_photo.dart';
import 'package:words/api/api_tags.dart';
import 'package:words/net/request.dart';
import 'package:words/view/detail/detail_list.dart';

class DetailTag extends StatefulWidget {
  final YTag item;
  const DetailTag({super.key, required this.item});

  @override
  State<DetailTag> createState() => _DetailTagState();
}

class _DetailTagState extends State<DetailTag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: SafeArea(
        child: DetailList(fetchData: fetchData),
      ),
    );
  }

  Future<List<YImg>> fetchData() async {
    var body = await YRequest(url_: widget.item.href).get();
    return ApiPhoto(body).imgs;
  }
}
