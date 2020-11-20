import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/preference.dart';
import 'package:deepvoice/view/widget/textfield.dart';
import 'package:deepvoice/view/widget/textAlert.dart';

class ProfileImage extends StatelessWidget {
  final User user;

  ProfileImage(this.user);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          child: Row(
            children: [
              Expanded(child: this.user.bot.avatar.toCircleImage()),
            ],
          ),
        ),
        Positioned(
          child: Container(
            width: 80,
            height: 80,
              child: InkWell(
                child: Image.asset('assets/main_profile.png'),
                onTap: () {

                },
              )

          ),
          right: -5,
          bottom: -5,
        )
      ],
    );
  }

  Future<String> _findSessionID() async{
    Preference p = await loadPreference();
    return p.sessionID;
  }
}