import 'package:flutter/material.dart';
import 'package:words/api/api_photo.dart';
import 'package:words/components/y_loding.dart';
import 'package:words/net/request.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:words/view/detail/detail_home.dart';

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});
  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  Future<List<YImg>> fetchData() async {
    var body = await YRequest().get();
    await Future.delayed(Duration(seconds: 2));
    return ApiPhoto(body).imgs;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
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
          ),
        ],
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
                    color: Theme.of(context).colorScheme.primary,
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
                color: Theme.of(context).colorScheme.shadow.withAlpha(150),
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.yImg.alt,
                      // textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.collections,
                          size: 12,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.yImg.detail,
                          style: TextStyle(color: Colors.white, fontSize: 8),
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
