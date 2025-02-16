import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:words/view/view_home.dart';
import 'package:words/view/view_tags.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> _views = [ViewHome(), ViewTags()];
  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // 设置状态栏背景色
      statusBarIconBrightness: Brightness.dark, // 设置状态栏图标的颜色（浅色）
    ));

    return MaterialApp(
      home: Scaffold(
        body: _views[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (value) => setState(() {
            _selectedIndex = value;
          }),
          destinations: [
            NavButton(
              icon: Icons.image_outlined,
              selectIcon: Icons.image,
              label: "Photo",
            ),
            NavButton(
              icon: Icons.category_outlined,
              selectIcon: Icons.category,
              label: "Category",
            ),
          ],
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconData? selectIcon;
  const NavButton({
    super.key,
    required this.label,
    required this.icon,
    this.selectIcon,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      label: label,
      icon: Icon(icon),
      selectedIcon: Icon(selectIcon ?? icon),
    );
  }
}
