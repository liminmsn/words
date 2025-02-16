import 'package:flutter/material.dart';

class ViewTags extends StatefulWidget {
  const ViewTags({super.key});

  @override
  State<ViewTags> createState() => _ViewTagsState();
}

class _ViewTagsState extends State<ViewTags> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [Text("hello")],
      ),
    );
  }
}
