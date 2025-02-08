import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'My app',
    home: SafeArea(child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          MyAppBar(
            title: Text('Example title',
                style: Theme.of(context).primaryTextTheme.titleLarge),
          ),
          const Expanded(
            child: Center(
              child: Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key, required this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.yellow[500]),
      child: Row(
        children: [
          const IconButton(
            tooltip: 'Navigation menu',
            icon: Icon(Icons.menu),
            onPressed: null,
          ),
          Expanded(child: Text('hello')),
          const IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          )
        ],
      ),
    );
  }
}
