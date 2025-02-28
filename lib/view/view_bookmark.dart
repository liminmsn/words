import 'package:flutter/material.dart';
import 'package:words/api/api_photo.dart';
import 'package:words/script/bookmark.dart';
import 'package:words/view/detail/detail_list.dart';

class ViewBookmark extends StatefulWidget {
  const ViewBookmark({super.key});

  @override
  State<ViewBookmark> createState() => _ViewBookmarkState();
}

class _ViewBookmarkState extends State<ViewBookmark> {
  late List<YImg> imgs = [];
  late bool notbook = false;

  @override
  void initState() {
    super.initState();
    fetchDate();
  }

  fetchDate() async {
    var res = await Bookmark.data();
    if (res.isNotEmpty) {
      setState(() {
        imgs = res;
        notbook = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: notbook
          ? GridView.builder(
              padding: const EdgeInsets.all(2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 2 / 3,
                crossAxisCount: 3,
              ),
              itemCount: imgs.length,
              itemBuilder: (context, index) {
                return YCard(
                  yImg: imgs[index],
                  idx: index + 1,
                  bookmark: false,
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.block,
                      size: 40, color: Theme.of(context).colorScheme.primary),
                  Text('No bookmark',
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer)),
                ],
              ),
            ),
    );
  }
}
