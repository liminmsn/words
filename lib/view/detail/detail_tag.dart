import 'package:flutter/material.dart';
import 'package:words/api/api_tags.dart';
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
        child: DetailList(
          url: widget.item.href,
        ),
      ),
    );
  }
}
