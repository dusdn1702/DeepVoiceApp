import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/appbar.dart';
import 'package:deepvoice/view/widget/audioPlayer.dart';
import 'package:deepvoice/view/widget/listAlert.dart';
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
            children: [
              SizedBox(height: 13.0),
              Search(),
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
      backgroundColor: Theme.of(context).primaryColor,
      title: Text("음성앨범", style: TextStyle(fontSize: 11),),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 12.3,),
        onPressed: () => {Navigator.pop(context)},
        iconSize: 28.0,
        color: Colors.white,
      ),
      centerTitle: true,
    );
  }

  Widget _voiceList(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
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
            SizedBox(width: 280),
            Text("Voice.size", style: TextStyle(
              color: Colors.black,
              fontSize: 8,
              fontWeight: FontWeight.normal,
            )),
          ]
      ),
      onTap: () {
        listAlert(context, _voiceTitleController);
      },
    );
  }
}
