import 'package:api_news_flutter/model/User.dart';
import 'package:flutter/material.dart';

class user_screen extends StatelessWidget {
  final bool isLoaded;
  final List<User> post;
  const user_screen({super.key, required this.isLoaded, required this.post});

  @override
  Widget build(BuildContext context) {
    return isLoaded == true
        ? ListView.builder(
            itemCount: post.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    post[index].name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  trailing: MediaQuery.of(context).size.width > 600
                      ? ElevatedButton.icon(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          icon: Icon(
                            Icons.arrow_forward_rounded,
                            size: 30,
                            color: Colors.blue,
                          ),
                          label: Text(
                            'Details',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_rounded,
                            size: 30,
                            color: Colors.blue,
                          )),
                  subtitle: Text(
                    post[index].email,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
