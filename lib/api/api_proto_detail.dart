import 'package:html/dom.dart';

interface class YImgDetail {
  late String src;
  late String title;
}

class ApiProtoDetail {
  List<YImgDetail> imgs = [];
  ApiProtoDetail(String body) {
    var dom = Document.html(body);
    var masonry = dom.querySelector("#masonry");
    var imgs_ = masonry!.getElementsByTagName("img");
    for (var img in imgs_) {
      var yimg = YImgDetail();
      yimg.src = "https:${img.attributes["data-original"]}";
      yimg.title = img.attributes["title"] ?? "null";
      imgs.add(yimg);
    }
  }
}
