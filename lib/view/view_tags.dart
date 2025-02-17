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
        children: [
          Text("hello"),
          FutureBuilder<String>(
            future: null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Data: ${snapshot.data}');
              }
            },
          ),
        ],
      ),
    );
  }
}
