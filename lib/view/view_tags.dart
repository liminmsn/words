import 'package:flutter/material.dart';
import 'package:words/api/api_tags.dart';
import 'package:words/components/y_loding.dart';
import 'package:words/net/request.dart';
import 'package:words/view/detail/detail_tag.dart';

class ViewTags extends StatefulWidget {
  const ViewTags({super.key});

  @override
  State<ViewTags> createState() => _ViewTagsState();
}

class _ViewTagsState extends State<ViewTags> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Yloding.buildr<List<YTag>>(
              future: fetchData,
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 每行显示2个项目
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 3 / 1,
                    ),
                    itemCount: snapshot.data?.length, // 总共6个项目
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailTag(
                                  item: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  snapshot.data![index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<YTag>> fetchData() async {
    var res = await YRequest().get();
    return ApiTags(res).tags;
  }
}
