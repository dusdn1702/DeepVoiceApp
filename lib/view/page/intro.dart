import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/page/login.dart';
import '../../preference.dart';
import 'mainPage.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 2),
      () async {
        Preference p =  await loadPreference();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => (p != null && p.isLogin()) ? MainPage() : LoginPage()),
        );
      }
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Container(
          width: 154,
          height: 123,
          child: Image.asset('assets/intro_logo.png'),
        ),
      ),
    );
  }
}