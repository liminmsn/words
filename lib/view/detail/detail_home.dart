import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:words/api/api_photo.dart';
import 'package:words/api/api_proto_detail.dart';
import 'package:words/net/request.dart';

class DetailHome extends StatefulWidget {
  final YImg item;
  const DetailHome({super.key, required this.item});

  @override
  State<DetailHome> createState() => _DetailHomeState();
}

class _DetailHomeState extends State<DetailHome> {
  List<YImgDetail> _imgs = [];
  late double height = MediaQuery.of(context).size.height * 0.8;
  late bool _showTop = false;

  //加载数据
  Future<List<YImgDetail>> fetchData() async {
    var body = await YRequest(url_: widget.item.url).get();
    return ApiProtoDetail(body).imgs;
  }

  //保存到本地
  Future<void> saveImage(YImgDetail y) async {
    final response = await http.get(Uri.parse(y.src));
    final bytes = response.bodyBytes;

    final filePath = await FlutterFileDialog.saveFile(
      params: SaveFileDialogParams(
          sourceFilePath: null, fileName: '${y.title}.jpg', data: bytes),
    );

    if (filePath != null) {
      // Saved successfully
    } else {
      // Save operation cancelled
      // print('Save operation cancelled');
    }
  }

  // 弹窗提示
  void onTap(YImgDetail y) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0), // 设置为0.0以去掉圆角
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  y.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Image.network(y.src),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Row(
                        children: [Text('Close'), Icon(Icons.close)],
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        // 按钮点击事件
                        await saveImage(y);
                      },
                      child: Row(
                        children: [Text('Save'), Icon(Icons.download)],
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

  getData() async {
    var data = await fetchData();
    setState(() => _imgs = data);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.alt),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            for (var i = 0; i < _imgs.length; i++)
              GestureDetector(
                onTap: () => onTap(_imgs[i]),
                child: Image.network(_imgs[i].src),
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
