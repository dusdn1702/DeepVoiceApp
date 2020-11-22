import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/voice.dart';
import 'package:deepvoice/view/page/login.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/audioPlayer.dart';
import 'package:deepvoice/view/widget/textAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'confirm.dart';

class CustomListAlert extends StatefulWidget {
  final TextEditingController _voiceTitleController;
  final Function onRefresh;
  Voice voice;

  CustomListAlert(this._voiceTitleController, this.voice, this.onRefresh);

  @override
  _CustomListAlertState createState() => _CustomListAlertState();
}

class _CustomListAlertState extends State<CustomListAlert> {
  @override
  void initState() {
    _findVoice(context, this.widget.voice.id).then((Voice result) {
      setState(() {
        this.widget.voice = result;
      });
    });
    super.initState();
  }

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
                audioPlayer(context, this.widget.voice); //voiceID
              }, "재생하기"),
              Container(
                  color: Colors.black,
                  height: 0.3
              ),
              _oneOfList(context, () {
                textAlert(context, "파일이름변경", this.widget.voice.name, "변경하기",
                    this.widget._voiceTitleController, onTap: () async {
                      bool ok = await _updateVoiceTitle(context, this.widget.voice.id, this.widget._voiceTitleController.text);  //voiceID
                      if (ok) {
                        FocusScope.of(context).unfocus();
                        this.widget.onRefresh();
                        alert(context, "파일 이름 변경에 성공했습니다.", "확인");
                      }
                    });
              }, "이름변경"),
              Container(
                  color: Colors.black,
                  height: 0.3
              ),
              _oneOfList(context, () {
                //여기에 공유함수
                alert(context, "서비스 준비 중입니다.", "닫기");
              }, "공유하기"),
              Container(
                  color: Colors.black,
                  height: 0.3
              ),
              _oneOfList(context, () {
                confirm(context, "음성 파일을 삭제하시겠습니까?", "확인", "닫기", () async {
                  bool ok = await _deleteVoice(context, this.widget.voice.id);  //voiceID
                  if (ok) {
                    this.widget.onRefresh();
                    alert(context, "음성 파일이 삭제되었습니다.", "확인", onTap: () {
                      Navigator.of(context).pop();
                    });
                  }
                });
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
        onPressed: onTap,
        child: Text(listTitle, textAlign: TextAlign.center),
      ),
    );
  }

  Future<Voice> _findVoice(BuildContext context, int voiceID) async {
    try {
      APIClient client = APIClient();
      Voice currentVoice = await client.getVoice(voiceID);
      return currentVoice;
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return null;
        } else if (e.errorCode == APIStatus.UnknownSession) {
          alert(context, "세션이 만료됐습니다.", "확인", onTap: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
          });
          return null;
        } else if (e.errorCode == APIStatus.NotFound) {
          alert(context, "음원 정보가 존재하지 않습니다.", "확인", onTap: () {
            Navigator.of(context).pop();
          });
          return null;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return null;
    }
  }

  Future<bool> _updateVoiceTitle(BuildContext context, int voiceID, String voiceName) async {
    try {
      APIClient client = APIClient();
      await client.updateVoiceName(voiceID, voiceName);
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
          alert(context, "음원 정보가 존재하지 않습니다.", "확인", onTap: () {
            Navigator.of(context).pop();
          });
          return false;
        } else if (e.errorCode == APIStatus.Duplicated) {
          alert(context, "중복된 이름이 존재합니다.", "확인", onTap: () {
            Navigator.of(context).pop();
          });
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
          alert(context, "음원 정보가 존재하지 않습니다.", "확인", onTap: () {
            Navigator.of(context).pop();
          });
          return false;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return false;
    }
  }
}

void listAlert(BuildContext context, TextEditingController inputController, Voice _voice, Function onRefresh) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomListAlert(inputController, _voice, onRefresh);
      }
  );
}