import 'package:html/dom.dart';

interface class YImg {
  late String src;
  late String alt;
  late String data;
  late String url;
}

class ApiPhoto {
  List<YImg> imgs = [];
  ApiPhoto(String body) {
    var html = Document.html(body);
    var liarr = html.querySelector("#masonry");
    var itemarr = liarr!.querySelectorAll(".item");
    for (var element in itemarr) {
      var img_ = element.getElementsByTagName("img")[0];
      var span_ = element.getElementsByClassName("item-num")[0];
      var img = YImg();
      img.alt = img_.attributes['alt'] ?? "null";
      img.data = img_.attributes['data-original'] ?? "null";
      img.src = img_.attributes['src'] ?? "null";
      img.url = span_.nodes[0]
          .toString()
          .replaceAll('\n', '')
          .replaceAll('"', '')
          .replaceAll('\t', '');
      imgs.add(img);
    }
  }
}
