import 'package:flutter/material.dart';
import 'package:words/api/api_photo.dart';
import 'package:words/net/request.dart';

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});
  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  List<YImg> _imgs = [];

  @override
  void initState() {
    super.initState();
    YRequest().get((r) {
      setState(() {
        _imgs = ApiPhoto(r).imgs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
        padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 2 / 3,
          crossAxisCount: 2,
        ),
        itemCount: _imgs.length,
        itemBuilder: (context, index) {
          return YCard(
            yImg: _imgs[index],
            idx: index + 1,
          );
        },
      ),
    );
  }
}

class YCard extends StatefulWidget {
  final YImg yImg;
  final int idx;
  const YCard({super.key, required this.yImg, required this.idx});

  @override
  State<YCard> createState() => _YCardState();
}

class _YCardState extends State<YCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      child: Stack(
        children: [
          Image.network("https:${widget.yImg.data}"),
          Positioned(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: -8,
                  child: Icon(
                    Icons.bookmark,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                color: Theme.of(context).colorScheme.outline.withAlpha(100),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.yImg.alt,
                      // textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.collections,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          widget.yImg.url,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
