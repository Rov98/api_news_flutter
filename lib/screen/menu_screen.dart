import 'package:api_news_flutter/model/Post.dart';
import 'package:flutter/material.dart';

class menu_screen extends StatelessWidget {
  final bool isLoaded;
  final List<Post> post;
  const menu_screen({super.key, required this.isLoaded, required this.post});

  @override
  Widget build(BuildContext context) {
    var fontSize = MediaQuery.of(context).textScaleFactor;
    return isLoaded == true
        ? LayoutBuilder(
            builder: (context, constrain) {
              return Card(
                elevation: 6,
                margin: EdgeInsets.all(constrain.maxWidth / 60),
                child: Text(
                  'All Post Was Found and ID sum is ' + post.length.toString(),
                  style: TextStyle(
                      fontSize: fontSize * 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
