import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/preference.dart';

class MainProfileImage extends StatelessWidget {

  final User user;

  MainProfileImage(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(child: this.user.bot.avatar.toCircleImage()),
    );
  }

  Future<String> _findSessionID() async{
    Preference p = await loadPreference();
    return p.sessionID;
  }
}