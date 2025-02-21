import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:words/api/api_photo.dart';
import 'package:words/net/request.dart';
import 'package:words/script/bookmark.dart';

import '../../components/y_loding.dart';
import 'detail_home.dart';

class DetailList extends StatefulWidget {
  final String? url;
  const DetailList({super.key, this.url});

  @override
  State<DetailList> createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {
  late String url;
  late bool shownav = false;
  late List<YImg> locaimgs = [];

  @override
  void initState() {
    super.initState();
    url = widget.url ?? YRequest.url;
    init();
  }

  init() async {
    var res = await Bookmark.data();
    if (res.isNotEmpty) {
      setState(() {
        locaimgs = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Yloding.buildr(
        future: fetchData,
        builder: (context, snapshot) {
          return Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  for (var item in snapshot.data!.pageNavigator)
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          if (item.current || item.label == "...") return;
                          setState(() {
                            url = item.href;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          color: item.current
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primaryContainer,
                          child: Text(
                            item.label,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                // fontSize: 14,
                                color: item.current
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  // padding: const EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 2 / 3,
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data?.imgs.length,
                  itemBuilder: (context, index) {
                    return YCard(
                      yImg: snapshot.data!.imgs[index],
                      idx: index + 1,
                      bookmark: locaimgs.any((element) =>
                          element.url == snapshot.data!.imgs[index].url),
                      // bookmark: Bookmark.isExist_(
                      //     locaimgs, snapshot.data!.imgs[index]),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<ApiPhoto> fetchData() async {
    var body = await YRequest(url_: url).get();
    return ApiPhoto(body);
  }
}

class YCard extends StatelessWidget {
  final YImg yImg;
  final int idx;
  final bool bookmark;
  const YCard({
    super.key,
    required this.yImg,
    required this.idx,
    required this.bookmark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailHome(item: yImg),
          ),
        );
      },
      child: Stack(
        children: [
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: yImg.data,
            imageErrorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(
                  Icons.not_interested_rounded,
                  size: 50,
                  color: Theme.of(context).colorScheme.error,
                ),
              );
            },
          ),
          Positioned(
            child: Stack(
              children: [
                bookmark
                    ? Positioned(
                        right: 0,
                        top: -8,
                        child: Icon(
                          Icons.bookmark,
                          size: 30,
                          color: Colors.red,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Theme.of(context).colorScheme.onPrimary.withAlpha(60),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    yImg.alt,
                    // textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        yImg.detail,
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: 8),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
