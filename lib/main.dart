import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var selectIndex = 0;
  late List<Widget> pageArr;

  @override
  void initState() {
    super.initState();
    pageArr = [Home(callback: setSelectIndex), ScaffoldTest()];
  }

  void setSelectIndex(int idx) {
    setState(() {
      selectIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          title: const Text(
            "My Home Page",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: pageArr[selectIndex],
      ),
    );
  }
}

class Home extends StatelessWidget {
  final Function(int) callback;
  const Home({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(builder: (context) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text('Hello, Flutter!'),
            ),
            ElevatedButton(
              onPressed: () {
                callback(1);
              },
              child: Text("A button"),
            ),
          ],
        );
      }),
    );
  }
}

class ScaffoldTest extends StatefulWidget {
  const ScaffoldTest({super.key});

  @override
  State<ScaffoldTest> createState() => _ScaffoldTestState();
}

class _ScaffoldTestState extends State<ScaffoldTest> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Code"),
      ),
      body: Center(
        child: Text('You have pressed the button $_count times.'),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _count++;
        }),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
