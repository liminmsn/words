import 'package:html/dom.dart';

interface class YPageNavigator {
  late String href;
  late String label;
  late bool current;
}

class YImg {
  late String alt;
  late String data;
  late String detail;
  late String url;

  YImg(
      {required this.url,
      required this.alt,
      required this.data,
      required this.detail});

  factory YImg.fromJson(Map<String, dynamic> json) {
    return YImg(
      url: json['url'],
      alt: json['alt'],
      data: json['data'],
      detail: json['detail'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'alt': alt,
      'data': data,
      'detail': detail,
    };
  }
}

class ApiPhoto {
  List<YImg> imgs = [];
  List<YPageNavigator> pageNavigator = [];
  ApiPhoto(String body) {
    var html = Document.html(body);
    var content = html.body!.querySelector(".content");
    var liarr = content!.querySelector("#masonry");
    var itemarr = liarr!.querySelectorAll(".item");
    for (var element in itemarr) {
      var img_ = element.getElementsByTagName("img")[0];
      var span_ = element.getElementsByClassName("item-num")[0];
      var a_ = element.getElementsByClassName("item-link")[0];
      var img = YImg(url: "", alt: "", data: "", detail: "");
      img.alt = (img_.attributes['alt'] ?? "null").replaceAll(' ', '');
      img.data = 'https:${img_.attributes["data-original"]}';
      img.detail = span_.nodes[0]
          .toString()
          .replaceAll('\n', '')
          .replaceAll('"', '')
          .replaceAll('\t', '');
      img.url = a_.attributes['href'] ?? "null";
      imgs.add(img);
    }
    var pagebtn =
        content.querySelector('.page-navigator')!.getElementsByTagName('li');
    for (var item in pagebtn) {
      var y = YPageNavigator();
      y.current = item.className == 'current' ? true : false;
      y.href = item.children[0].attributes['href'] ?? "null";
      y.label = item.children[0].text;
      pageNavigator.add(y);
    }
  }
}
