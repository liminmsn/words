import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("data:"),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () async{
              var res = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
              print(res);
            },
            child: Icon(Icons.http_outlined),
          )
        ],
      ),
    );
  }
}
