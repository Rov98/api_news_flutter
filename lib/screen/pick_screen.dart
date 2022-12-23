import 'package:api_news_flutter/screen/menu_screen.dart';
import 'package:api_news_flutter/screen/user_screen.dart';
import 'package:api_news_flutter/screen/web_domain_screen.dart';
import 'package:flutter/material.dart';

class pick_screen extends StatefulWidget {
  const pick_screen({Key? key}) : super(key: key);

  @override
  State<pick_screen> createState() => _pick_screenState();
}

class _pick_screenState extends State<pick_screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: ListView(
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => menu_screen()));
            },
            child: Text('Post Data Restfull Api')),
        SizedBox(
          height: 20,
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => user_screen()));
            },
            child: Text('User Screen Restfull Api')),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => web_domain_screen()));
            },
            child: Text('Web Domain Restfull Api')),
      ],
    ))));
  }
}
