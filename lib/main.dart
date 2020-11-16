import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/view/page/intro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  APIClient(url: "http://34.64.125.50:7777");

  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    ThemeData theme = ThemeData(
      primaryColor: const Color(0xff8b80f9),
      buttonColor: const Color(0xff7165e3),
      accentColor: const Color(0xff9999ff),
      errorColor: const Color(0xffff9999),
    );

    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
