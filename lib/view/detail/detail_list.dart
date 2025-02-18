import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:words/api/api_photo.dart';

import '../../components/y_loding.dart';
import 'detail_home.dart';

class DetailList extends StatelessWidget {
  final Future<List<YImg>> Function() fetchData;
  const DetailList({super.key, required this.fetchData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Yloding.buildr(
        future: fetchData,
        builder: (context, snapshot) {
          return GridView.builder(
            padding: const EdgeInsets.all(5),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 2 / 3,
              crossAxisCount: 3,
            ),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return YCard(
                yImg: snapshot.data![index],
                idx: index + 1,
              );
            },
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailHome(item: widget.yImg),
          ),
        );
      },
      child: Stack(
        children: [
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: widget.yImg.data,
          ),
          Positioned(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: -8,
                  child: Icon(
                    Icons.bookmark,
                    size: 30,
                    color: Theme.of(context).colorScheme.primaryContainer,
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
                color: Theme.of(context).colorScheme.secondary.withAlpha(100),
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.yImg.alt,
                      // textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.collections,
                          size: 12,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.yImg.detail,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 8),
                        ),
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
