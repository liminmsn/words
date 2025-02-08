import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text("hello world"),
            Expanded(
              child: ListView(
                children: [
                  for (var item in nouns.take(10))
                    ListTile(
                      title: Text(item),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
