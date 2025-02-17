import 'package:flutter/material.dart';

class Yloding {
  static buildr<T>({
    required Future<T> Function() future,
    required Widget Function(BuildContext context, AsyncSnapshot<T> snapshot)
        builder,
  }) {
    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Loding...")
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return builder(context, snapshot);
        }
      },
    );
  }
}
