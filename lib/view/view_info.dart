import 'package:flutter/material.dart';

class ViewInfo extends StatefulWidget {
  const ViewInfo({super.key});

  @override
  State<ViewInfo> createState() => _ViewInfoState();
}

class _ViewInfoState extends State<ViewInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text("hello"),
      ),
    );
  }
}
