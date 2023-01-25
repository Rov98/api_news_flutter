import 'package:flutter/material.dart';
import './login_screen.dart';

class auth_screen extends StatelessWidget {
  const auth_screen({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceScreen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: deviceScreen.height,
              width: deviceScreen.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Flexible(child: login_screen())],
              ),
            ),
          )
        ],
      ),
    );
  }
}
