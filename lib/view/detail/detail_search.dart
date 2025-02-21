import 'package:flutter/material.dart';
import 'package:words/view/detail/detail_list.dart';

class DetailSearch extends StatefulWidget {
  final String label;
  const DetailSearch({super.key, required this.label});

  @override
  State<DetailSearch> createState() => _DetailSearchState();
}

class _DetailSearchState extends State<DetailSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
      ),
      body: Column(
        children: [
          DetailList(
            url: "https://www.fulitu.cc/search/${widget.label}/",
          ),
        ],
      ),
    );
  }
}
