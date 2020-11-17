import 'package:deepvoice/model/bot.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/widget/sidebar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Deep Voice'),
      ),
      endDrawer: SideBar("1", Gender.from("M"), "3", AvatarType.from("CAT")),
    );
  }
}