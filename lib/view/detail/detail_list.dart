import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:words/api/api_photo.dart';
import 'package:words/net/request.dart';

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

  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    url = widget.url ?? YRequest.url;
    controller.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(listener);
    controller.dispose();
  }

  void listener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      // setState(() => shownav = true);
    } else if (controller.position.pixels ==
        controller.position.minScrollExtent) {
      // setState(() => shownav = false);
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
                          if (item.current) return;
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
                                fontSize: 10,
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
                  controller: controller,
                  // padding: const EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisCount: 3,
                  ),
                  itemCount: snapshot.data?.imgs.length,
                  itemBuilder: (context, index) {
                    return YCard(
                      yImg: snapshot.data!.imgs[index],
                      idx: index + 1,
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
                color: Theme.of(context).colorScheme.secondary.withAlpha(200),
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
