import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:words/api/api_photo.dart';
import 'package:words/api/api_proto_detail.dart';
import 'package:words/components/y_image.dart';
import 'package:words/net/request.dart';
import 'package:words/script/bookmark.dart';
import 'package:words/script/keys.dart';

class DetailHome extends StatefulWidget {
  final YImg item;

  const DetailHome({super.key, required this.item});

  @override
  State<DetailHome> createState() => _DetailHomeState();
}

class _DetailHomeState extends State<DetailHome> {
  List<YImgDetail> _imgs = [];
  late double height = MediaQuery.of(context).size.height * 0.8;
  late bool makeBookmark = false;
  late bool _showTop = false;
  late bool activeState = false;

  //加载数据
  Future<List<YImgDetail>> fetchData() async {
    var body = await YRequest(url_: widget.item.url).get();
    return ApiProtoDetail(body).imgs;
  }

  //保存到本地
  Future<void> saveImage(YImgDetail y) async {
    final response = await http.get(Uri.parse(y.src));
    final bytes = response.bodyBytes;

    // ignore: use_build_context_synchronously
    if (Theme.of(context).platform == TargetPlatform.android ||
        // ignore: use_build_context_synchronously
        Theme.of(context).platform == TargetPlatform.iOS) {
      final filePath = await FlutterFileDialog.saveFile(
        params: SaveFileDialogParams(
            sourceFilePath: null, fileName: '${y.title}.jpg', data: bytes),
      );

      if (filePath != null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Storage successful!'),
            action: SnackBarAction(
              label: 'Finish',
              onPressed: () {
                // Code to execute.
              },
            ),
          ),
        );
      } else {
        // Save operation cancelled
        // print('Save operation cancelled');
      }
    }
  }

  // 弹窗提示
  void onTap(YImgDetail y) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 10.0),
                // Text(
                //   y.title,
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 18.0,
                //   ),
                // ),
                // SizedBox(height: 10.0),
                Card(
                  child: Image.network(y.src),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Icon(Icons.highlight_off, size: 30),
                      ),
                    ),
                    SizedBox(width: 10),
                    Card(
                      child: TextButton(
                        onPressed: () async {
                          await saveImage(y);
                        },
                        child: Icon(Icons.arrow_circle_down, size: 30),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  //加载数据
  getData() async {
    var isExist = await Bookmark.isExist(widget.item);
    var data = await fetchData();
    var isactive = await Keys().getActiveState();
    setState(() {
      _imgs = data;
      makeBookmark = isExist;
      activeState = isactive;
    });
  }

  //大于500显示top按钮
  void _scrollListener() {
    if (_scrollController.offset >= height && !_showTop) {
      setState(() => _showTop = true);
    } else if (_scrollController.offset <= height && _showTop) {
      setState(() => _showTop = false);
    }
  }

  //返回顶部
  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.alt),
        actions: <Widget>[
          IconButton(
            icon: makeBookmark
                ? Icon(Icons.bookmark, size: 30, color: Colors.red)
                : Icon(Icons.bookmark_border, size: 30),
            onPressed: () async {
              if (makeBookmark) {
                await Bookmark.del(widget.item);
              } else {
                await Bookmark.add(widget.item);
              }
              setState(() {
                makeBookmark = !makeBookmark;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: activeState ? null : NeverScrollableScrollPhysics(),
        controller: _scrollController,
        child: Column(
          children: [
            for (var i = 0; i < _imgs.length; i++)
              GestureDetector(
                onTap: () => onTap(_imgs[i]),
                // onLongPress: () => onTap(_imgs[i]),
                child: YImage(url: _imgs[i].src, sy: activeState == false),
              ),
          ],
        ),
      ),
      floatingActionButton: _showTop
          ? FloatingActionButton(
              onPressed: scrollToTop,
              child: Icon(Icons.expand_less),
            )
          : null,
    );
  }
}
