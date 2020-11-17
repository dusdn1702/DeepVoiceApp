import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/audioPlayer.dart';
import 'package:deepvoice/view/widget/textAlert.dart';
import 'package:deepvoice/view/widget/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';

class CustomListAlert extends StatelessWidget {
  final TextEditingController _voiceTitleController;

  CustomListAlert(this._voiceTitleController);

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
              _oneOfList(context, (){
                audioPlayer(context, "1");
              }, "재생하기"),
              Container(
                  color: Colors.black,
                  height: 0.3
              ),
              _oneOfList(context, (){
                textAlert(context, "파일이름변경", "현재파일명노출란", "변경하기", this._voiceTitleController);
              }, "이름변경"),
              Container(
                  color: Colors.black,
                  height: 0.3
              ),
              _oneOfList(context, (){
                //여기에 공유함수
                alert(context, "서비스 준비 중입니다.", "닫기");
              }, "공유하기"),
              Container(
                  color: Colors.black,
                  height: 0.3
              ),
              _oneOfList(context, (){
                alert(context, "서비스 준비 중입니다.", "닫기");
              }, "삭제하기"),
            ],
          ),
        ),
      ),
    );
  }
  Widget _oneOfList(BuildContext context, Function onTap, String listTitle){
    return  Container(
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        onPressed: onTap,
        child: Text(listTitle, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11)),
      ),
    );
  }
}

void listAlert(BuildContext context, TextEditingController inputController) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomListAlert(inputController);
      }
  );
}