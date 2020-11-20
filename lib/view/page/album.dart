import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/model/voice.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/appbar.dart';
import 'package:deepvoice/view/widget/audioPlayer.dart';
import 'package:deepvoice/view/widget/listAlert.dart';
import 'package:deepvoice/view/widget/search.dart';
import 'package:deepvoice/view/widget/textAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlbumPage extends StatefulWidget {
  List<Voice> voiceList;

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final _voiceTitleController = TextEditingController();
  final _voiceInputController = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');

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
              Column(
                children: _getVoiceList(),
              ),
            ],
          ),
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      ),
      floatingActionButton: _addVoiceButton(context),
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

  List<Voice> voiceList = [];
  List<Widget> _getVoiceList() {
    List<Widget> voices = new List<Widget>();
    _findVoiceList().then((List<Voice> result){
      setState(() {
        voiceList = result;
      });
    });
    if (voiceList.isNotEmpty) {
      for (int i = 0; i < voiceList.length; i++) {
        voices.add(_voiceList(voiceList[i]));
      }
    }
    return voices;
  }

  Future<List<Voice>>_findVoiceList() async{
    try {
      APIClient client = APIClient();
      return await client.getVoiceList();
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return null;
        } else if (e.errorCode == APIStatus.UnknownSession) {
          alert(context, "세션이 만료됐습니다.", "확인", onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          });
          return null;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return null;
    }
  }

  Widget _voiceList(Voice voice) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
      title: Text(voice.name, style: TextStyle(
        color: Colors.black,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      )),
      subtitle: Row(
          children: [
            Text(formatter.format(
                voice.timestamp.subtract(new Duration(hours: -9))),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 8,
                  fontWeight: FontWeight.normal,
                )),
            SizedBox(width: 270,),
            Text(voice.size.toString() + 'MB', style: TextStyle(
                color: Colors.black,
                fontSize: 8,
                fontWeight: FontWeight.normal,
              )),
          ]
      ),
      onTap: () {
        listAlert(context, _voiceTitleController, voice);
      },
    );
  }

  Widget _addVoiceButton(BuildContext context){
    return FloatingActionButton(
      child: Image.asset("assets/friend_add.png"),
      onPressed: () => {
        textAlert(context, "음성추가", "추가하고자 하는 텍스트를 입력하세요.", "추가하기", this._voiceInputController, onTap: (){
          _onTapAddVoice(this._voiceInputController.text);
        })
      },
    );
  }


  Future<void>_onTapAddVoice(String text) async{
    try {
      APIClient client = APIClient();
      return await client.addVoice(text);
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return null;
        } else if (e.errorCode == APIStatus.UnknownSession) {
          alert(context, "세션이 만료됐습니다.", "확인", onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          });
          return null;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return null;
    }
  }
}
