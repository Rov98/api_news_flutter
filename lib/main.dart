import 'package:api_news_flutter/screen/new_screen.dart';
import 'package:api_news_flutter/screen/splash_screen.dart';

import './screen/Auth/auth_screen.dart';
import './connect/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  //for potrait orientation only
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: Auth())],
        child: Consumer<Auth>(
          builder: (context, authentication, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: authentication.isAuth
                ? new_screen()
                : //trying autoLogin
                FutureBuilder(
                    future: authentication.autoLogin(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return splashScreen();
                      } else {
                        return auth_screen();
                      }
                    },
                  ),
          ),
        ));
  }
}
