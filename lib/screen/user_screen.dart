import 'dart:developer';

import 'package:api_news_flutter/connect/remote_services.dart';
import 'package:api_news_flutter/model/User.dart';
import 'package:flutter/material.dart';

class user_screen extends StatefulWidget {
  const user_screen({Key? key}) : super(key: key);

  @override
  State<user_screen> createState() => _user_screenState();
}

class _user_screenState extends State<user_screen> {
  List<User>? user;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    userGetData();
  }

  userGetData() async {
    user = await Remote_services().getUser();
    if (user != null) {
      print('Data loaded');
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Visibility(
          visible: isLoaded,
          child: ListView.builder(
              itemCount: user?.length,
              itemBuilder: (context, index) {
                return Text(user![index].username);
              }),
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
