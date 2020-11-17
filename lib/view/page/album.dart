import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/appbar.dart';
import 'package:deepvoice/view/widget/audioPlayer.dart';
import 'package:deepvoice/view/widget/search.dart';
import 'package:deepvoice/view/widget/textAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumPage extends StatefulWidget {
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final _voiceTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: GestureDetector(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: [
              SizedBox(height: 13.0),
              //Search(),
              SizedBox(height: 10.0),
              _voiceList(context),
            ],
          ),
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      title: Text("음성앨범"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => {Navigator.pop(context)},
        iconSize: 28.0,
        color: Colors.white,
      ),
      centerTitle: true,
    );
  }

  Widget _voiceList(BuildContext context) {
    return ListTile(
      title: Text("Voice.name", style: TextStyle(
        color: Colors.black,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      )),
      subtitle: Row(
          children: [
            Text("Voice.date", style: TextStyle(
              color: Colors.black,
              fontSize: 8,
              fontWeight: FontWeight.normal,
            )),
            SizedBox(width: 270.8),
            Text("Voice.size", style: TextStyle(
              color: Colors.black,
              fontSize: 8,
              fontWeight: FontWeight.normal,
            )),
          ]
      ),
      onTap: () {
        _voiceAlert(context);
      },
    );
  }

  Widget _voiceAlert(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
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
              RaisedButton(
                onPressed: () => {
                  //audioPlayer(context, "voiceTitle")
                },
                child: Text("재생하기", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11)),
              ),
              SizedBox(height: 0.3),
              RaisedButton(
                onPressed: () => {
                  textAlert(context, "파일이름변경", "현재파일명노출란", "변경하기", this._voiceTitleController)
                },
                child: Text("이름변경", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11)),
              ),
              SizedBox(height: 0.3),
              RaisedButton(
                onPressed: () =>
                {
                  //여기에 공유함수
                  alert(context, "서비스 준비 중입니다.", "닫기"),
                },
                child: Text("공유하기", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11)),
              ),
              SizedBox(height: 0.3),
              RaisedButton(
                onPressed: () => {
                  //여기에 공유함수
                  alert(context, "서비스 준비 중입니다.", "닫기"),
                },
                child: Text("삭제하기", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
