import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:words/api/api_tags.dart';
import 'package:words/net/request.dart';

class ViewTags extends StatefulWidget {
  const ViewTags({super.key});

  @override
  State<ViewTags> createState() => _ViewTagsState();
}

class _ViewTagsState extends State<ViewTags> {
  List<YTag> _tags = [];

  Future<String> fetchData() async {
    var res = await YRequest().get();
    return res;
  }

  getData() async {
    var body_ = await fetchData();
    setState(() {
      _tags = ApiTags(body_).tags;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 每行显示2个项目
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: _tags.length, // 总共6个项目
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    color: Theme.of(context)
                        .primaryColor
                        .withAlpha(100 * (index % 9)),
                    child: Center(
                      child: Text('Item ${_tags[index].title}'),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
