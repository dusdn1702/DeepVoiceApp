import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarTitle;
  final Icon appBarIcon;

  CustomAppBar(this.appBarTitle, this.appBarIcon);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.appBarTitle),
      leading: IconButton(
        icon: appBarIcon,
        onPressed: () => {Navigator.pop(context)},
        iconSize: 28.0,
        color: Colors.white,
      ),
      centerTitle: true,
    );
  }
}
