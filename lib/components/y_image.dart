import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class YImage extends StatelessWidget {
  final String url;
  final bool sy;
  const YImage({super.key, required this.url, required this.sy});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: url,
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
        sy
            ? Positioned(
                left: 80,
                right: 0,
                bottom: 0,
                top: 40,
                child: Icon(
                  Icons.bedtime,
                  color: Colors.white,
                  size: 200,
                ),
              )
            : Container(),
      ],
    );
  }
}
