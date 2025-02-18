import 'package:flutter/material.dart';
import 'package:words/view/detail/detail_list.dart';

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});
  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          DetailList(),
        ],
      ),
    );
  }
}
