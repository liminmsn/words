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
        body: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < 3; i++)
                Expanded(
                  child: Column(
                    children: [
                      BorderedImage(),
                      Text(i.toString()),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BorderedImage extends StatelessWidget {
  const BorderedImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            offset: Offset(1, 1),
          ),
          BoxShadow(color: Colors.white),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: FlutterLogo(
        size: 100,
      ),
    );
  }
}
