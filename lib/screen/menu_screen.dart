import 'package:api_news_flutter/connect/remote_services.dart';
import 'package:api_news_flutter/model/Post.dart';
import 'package:flutter/material.dart';

class menu_screen extends StatefulWidget {
  const menu_screen({Key? key}) : super(key: key);

  @override
  State<menu_screen> createState() => _menu_screenState();
}

class _menu_screenState extends State<menu_screen> {
  List<Post>? post;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getFetchData();
  }

  getFetchData() async {
    post = await Remote_services().getPost();
    if (post != null) {
      print('Data Loaded');
      setState(() {
        isLoaded = true;
      });
    }
  }

  //pengunaan visibility sangat dianjurkan karena akan bekerja. tidak seperti future.delayed
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
        itemCount: post?.length,
        itemBuilder: (context, index) {
          return Text(post![index].title);
        },
      ),
      replacement: Center(
        child: CircularProgressIndicator(),
      ),
      )
    );
  }
}
