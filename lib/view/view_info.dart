import 'package:flutter/material.dart';
import 'package:words/native/native_main.dart';

class ViewInfo extends StatefulWidget {
  const ViewInfo({super.key});

  @override
  State<ViewInfo> createState() => _ViewInfoState();
}

class _ViewInfoState extends State<ViewInfo> {
  late String _uid = '00-00-00-00';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "UID: $_uid",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var a = await NativeMain.uuid;
                setState(() {
                  _uid = a;
                });
              },
              child: Text("Get UID"),
            ),
          ],
        ),
      ),
    );
  }
}
