import 'package:html/dom.dart';

interface class YImg {
  late String alt;
  late String data;
  late String detail;
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
      var a_ = element.getElementsByClassName("item-link")[0];
      var img = YImg();
      img.alt = img_.attributes['alt'] ?? "null";
      img.data = 'https:${img_.attributes["data-original"]}';
      img.detail = span_.nodes[0]
          .toString()
          .replaceAll('\n', '')
          .replaceAll('"', '')
          .replaceAll('\t', '');
      img.url = a_.attributes['href'] ?? "null";
      imgs.add(img);
    }
  }
}
