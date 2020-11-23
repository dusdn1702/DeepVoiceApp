import 'package:deepvoice/view/page/friendSearch.dart';
import 'package:deepvoice/view/widget/audioPlayer.dart';
import 'package:deepvoice/view/widget/confirm.dart';
import 'package:deepvoice/view/widget/no_data.dart';
import 'package:deepvoice/view/widget/textAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/voice.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/voice_select.dart';
import 'package:deepvoice/view/widget/search.dart';

import 'login.dart';

class AlbumPage extends StatefulWidget {
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
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
              modalVoiceSelect(context, (String type) {
                if (type == VoiceSelectView.PLAY) {
                  this._onTapPlay(voice);
                } else if (type == VoiceSelectView.CHANGE) {
                  this._onTapChange(voice);
                } else if (type == VoiceSelectView.SHARE) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FriendSearchPage(voice)),
                  );
                } else if (type == VoiceSelectView.DELETE) {
                  this._onTapDelete(voice);
                }
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

  void _onTapPlay(Voice voice) {
    audioPlayer(context, voice: voice);
  }

  void _onTapChange(Voice voice) {
    textAlert(context, "파일이름변경", voice.name, "변경하기", (String v) async {
      if (v.isEmpty) {
        alert(context, "변경할 파일 이름을 입력해주세요.", "확인");
        return;
      }

      bool ok = await _updateVoiceName(context, voice.id, v);
      if (ok) {
        FocusScope.of(context).unfocus();
        this._findVoiceList();
        alert(context, "파일 이름 변경에 성공했습니다.", "확인");
      }
    });
  }

  void _onTapDelete(Voice voice) {
    confirm(context, "음성 파일을 삭제하시겠습니까?", "확인", "닫기", () async {
      bool ok = await _deleteVoice(context, voice.id);  //voiceID
      if (ok) {
        this._findVoiceList();
        alert(context, "음성 파일이 삭제되었습니다.", "확인");
      }
    });
  }

  Future<bool> _updateVoiceName(BuildContext context, int voiceID, String name) async {
    try {
      APIClient client = APIClient();
      await client.updateVoiceName(voiceID, name);
      return true;
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return false;
        } else if (e.errorCode == APIStatus.UnknownSession) {
          alert(context, "세션이 만료됐습니다.", "확인", onTap: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
          });
          return false;
        } else if (e.errorCode == APIStatus.NotFound) {
          alert(context, "음원 정보가 존재하지 않습니다.", "확인");
          return false;
        } else if (e.errorCode == APIStatus.Duplicated) {
          alert(context, "중복된 이름이 존재합니다.", "확인");
          return false;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return false;
    }
  }

  Future<bool> _deleteVoice(BuildContext context, int voiceID) async {
    try {
      APIClient client = APIClient();
      await client.deleteVoice(voiceID);
      return true;
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return false;
        } else if (e.errorCode == APIStatus.UnknownSession) {
          alert(context, "세션이 만료됐습니다.", "확인", onTap: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
          });
          return false;
        } else if (e.errorCode == APIStatus.NotFound) {
          alert(context, "음원 정보가 존재하지 않습니다.", "확인");
          return false;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return false;
    }
  }
}
