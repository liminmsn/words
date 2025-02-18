import 'package:html/dom.dart';

interface class YTag {
  late String href;
  late String title;
}

class ApiTags {
  List<YTag> tags = [];
  ApiTags(String html) {
    var dom = Document.html(html);
    var menu = dom.querySelector(".dropdown-menu");
    var lis = menu!.getElementsByTagName("li");
    for (var element in lis) {
      var tag = YTag();
      var a = element.getElementsByTagName("a")[0];
      tag.href = a.text;
      tag.title = a.text;
      tags.add(tag);
    }
  }
}
