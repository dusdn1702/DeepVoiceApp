import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deepvoice/model/user.dart';

class ProfileImage extends StatelessWidget {
  final User user;
  final double radius;
  final Function onTap;

  ProfileImage(this.user, this.radius, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          width: this.radius,
          height: this.radius,
          child: this.user.bot.avatar.toCircleImage(),
        ),
        Positioned(
          child: Container(
            width: this.radius / 187.0 * 45.0,
            height: this.radius / 187.0 * 45.0,
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Image.asset('assets/main_profile.png'),
              onTap: this.onTap,
            )
          ),
          right: -0,
          bottom: -0,
        )
      ],
    );
  }
}