import 'package:api_news_flutter/connect/auth.dart';
import 'package:api_news_flutter/connect/remote_services.dart';
import 'package:api_news_flutter/model/Post.dart';
import 'package:api_news_flutter/model/User.dart';
import 'package:api_news_flutter/screen/menu_screen.dart';
import 'package:api_news_flutter/screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class new_screen extends StatefulWidget {
  const new_screen({super.key});

  @override
  State<new_screen> createState() => _new_screenState();
}

class _new_screenState extends State<new_screen> {
  List<User> post = [];
  List<Post> all_post = [];
  bool isLoaded = false;
  bool isPostLoaded = false;
  bool _showSumId = true;

  @override
  void initState() {
    super.initState();
    getFetchData();
    getFetchPost();
  }

  void getFetchData() async {
    post = (await Remote_services().getUser())!;
    if (post != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void getFetchPost() async {
    all_post = (await Remote_services().getPost())!;
    if (all_post != null) {
      setState(() {
        isPostLoaded = true;
      });
    }
  }

  void _showAddModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 0
                        : MediaQuery.of(context).viewInsets.bottom + 10),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Add new names:'),
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                  ),
                  Text('Add new ID:'),
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('Add Data')),
                  )
                ],
              ),
            ),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
    title: Text('Rest Api Data Potrait/Lndscp'),
    actions: [
      IconButton(
          onPressed: () {
            Provider.of<Auth>(context, listen: false).logOut();
          },
          icon: Icon(Icons.exit_to_app))
    ],
  );
    final _mediaQuery = MediaQuery.of(context);
    final _isLandscape = _mediaQuery.orientation == Orientation.landscape;
    final _appHeight = _mediaQuery.size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandscape)
              Container(
                  height: _appHeight * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Show ID Sums'),
                      Switch(
                          value: _showSumId,
                          onChanged: (val) {
                            setState(() {
                              _showSumId = val;
                            });
                          }),
                    ],
                  )),
            _showSumId
                ? Container(
                    alignment: Alignment.center,
                    height: _appHeight * 0.15,
                    child: menu_screen(
                        isLoaded: isPostLoaded, post: all_post.toList()))
                : Container(),
            Container(
              height: _appHeight * 0.8,
              child: user_screen(
                isLoaded: isLoaded,
                post: post.toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddModal(context);
        },
      ),
    );
  }
}
