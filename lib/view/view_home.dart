import 'package:flutter/material.dart';
import 'package:words/net/request.dart';
import 'dart:convert';

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});
  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  String body = "none";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(body),
            ElevatedButton(
              onPressed: () {
                YRequest().get((body) {
                  setState(() {
                    this.body = body;
                  });
                });
              },
              child: Text("Get"),
            ),
          ],
        ),
      ),
    );
  }
}
