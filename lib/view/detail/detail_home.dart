import 'package:flutter/material.dart';
import 'package:words/api/api_photo.dart';

class DetailHome extends StatelessWidget {
  final YImg item;
  const DetailHome({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.alt),
      ),
      body: Container(
        color: Colors.amber,
        child: Text(item.url),
      ),
    );
  }
}
