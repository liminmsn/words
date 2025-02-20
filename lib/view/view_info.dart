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
            Text('UID: $_uid'),
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
