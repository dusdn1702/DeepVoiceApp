import 'package:deepvoice/view/widget/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/voice.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/listAlert.dart';
import 'package:deepvoice/view/widget/search.dart';

import 'login.dart';

class AlbumPage extends StatefulWidget {

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final _updateTitleController = TextEditingController();
  final _searchController = TextEditingController();
  List<Voice> voiceList = [];

  @override
  void initState() {
    _findVoiceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: GestureDetector(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 13.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Search(this._searchController, (String v) {
                  _findVoiceList();
                }),
              ),
              SizedBox(height: 10.0),
              Expanded(child: this.voiceList.length == 0 ? NoData() : _voiceListView()),
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

  ListView _voiceListView() {
    return ListView.builder(
      itemCount: this.voiceList.length,
      itemBuilder: (BuildContext context, int index) {
        return this._voiceListItem(this.voiceList[index]);
      }
    );
  }

  Future<void> _findVoiceList() async{
    try {
      APIClient client = APIClient();
      List<Voice> voice =  await client.getVoiceList(name: this._searchController.text);
      setState(() {
        this.voiceList = voice;
      });
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return;
        } else if (e.errorCode == APIStatus.UnknownSession) {
          alert(context, "세션이 만료됐습니다.", "확인", onTap: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
          });
          return;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return;
    }
  }

  Widget _voiceListItem(Voice voice) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          ListTile(
            title: Text(voice.name, style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(voice.timestampToString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )),
                  Text(voice.sizeToString(), style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  )),
                ]
            ),
            onTap: () {
              listAlert(context, this._updateTitleController, voice, () {
                this._updateTitleController.clear();
                this._findVoiceList();
              });
            },
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Color(0xffcccccc),
          ),
        ],),);
  }
}
