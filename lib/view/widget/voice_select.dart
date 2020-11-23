import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/view/page/login.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoiceSelectView extends StatelessWidget {
  static final String PLAY = "PLAY";
  static final String CHANGE = "CHANGE";
  static final String SHARE = "SHARE";
  static final String DELETE = "DELETE";

  final Function(String) onTap;
  VoiceSelectView(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          width: MediaQuery
              .of(context)
              .size
              .width - (70.0 * 2.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              const Radius.circular(7.5),
            ),
          ),
          child: Column(
            children: [
              _oneOfList(context, () {
                this.onTap(PLAY);
              }, "재생하기"),
              Container(
                  color: Colors.black,
                  height: 0.3
              ),
              _oneOfList(context, () {
                this.onTap(CHANGE);
              }, "이름변경"),
              Container(
                  color: Colors.black,
                  height: 0.3
              ),
              _oneOfList(context, () {
                this.onTap(SHARE);
              }, "공유하기"),
              Container(
                  color: Colors.black,
                  height: 0.3
              ),
              _oneOfList(context, () {
                this.onTap(DELETE);
              }, "삭제하기"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _oneOfList(BuildContext context, Function onTap, String listTitle) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
          onTap();
        },
        child: Text(listTitle, textAlign: TextAlign.center),
      ),
    );
  }
}

void modalVoiceSelect(BuildContext context, Function(String) onTap) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return VoiceSelectView(onTap);
      }
  );
}