import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:words/view/view_home.dart';
import 'package:words/view/view_info.dart';
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
  final List<Widget> _views = [ViewHome(), ViewTags(), ViewInfo()];
  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // 设置状态栏图标的颜色（浅色）
    ));

    return MaterialApp(
      theme: ThemeData.light().copyWith(
        // 亮色主题
        primaryColor: Colors.blue, // 设置主色调
        hintColor: Colors.green, // 设置强调色
      ),
      darkTheme: ThemeData.dark().copyWith(
        // 暗色主题
        primaryColor: Colors.purple, // 设置主色调
        hintColor: Colors.amber, // 设置强调色
      ),
      themeMode: ThemeMode.system, // 根据系统设置亮色或暗色主题
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welfare Rabbit"),
        ),
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
            NavButton(
              icon: Icons.info_outline,
              selectIcon: Icons.info,
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
