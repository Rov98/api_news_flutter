import 'dart:developer';

import 'package:api_news_flutter/model/Post.dart';
import 'package:api_news_flutter/model/User.dart';
import 'package:http/http.dart' as http;

class Remote_services {
  Future<List<Post>?> getPost() async {
    var client = http.Client();
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await client.get(url);

    try {
      if (response.statusCode == 200) {
        String json = response.body;
        return postFromJson(json);
        // final data = postFromJson(jsonDecode(json));
        // return data;
      }
    } catch (e) {
      log(e.toString());
      print(e.toString());
    }
  }

  Future<List<User>?> getUser() async {
    var client = http.Client();
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await client.get(url);

    try {
      if (response.statusCode == 200) {
        String json = response.body;
        return userFromJson(json);
      }
    } catch (e) {
      log(e.toString());
      print(e.toString());
    }
  }
}
