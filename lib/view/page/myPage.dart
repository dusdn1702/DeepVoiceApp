import 'dart:io';

import 'package:deepvoice/view/widget/textAlert.dart';
import 'package:deepvoice/view/page/updatePassword.dart';
import 'package:deepvoice/view/widget/profileImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:deepvoice/view/widget/button.dart';
import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/preference.dart';
import 'package:deepvoice/view/widget/alert.dart';


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  User _currentUser;
  TextEditingController _myNickController = TextEditingController();

  @override
  void initState() async {
    this._currentUser = await _findUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: GestureDetector(
            child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  children: [
                    SizedBox(height: 29),
                    Row(
                      children: [
                        SizedBox(width: 26),
                        Expanded(child: ProfileImage(this._currentUser)),
                        SizedBox(width: 26)
                      ],
                    ),
                    SizedBox(height: 37),
                    _myNick(),
                    SizedBox(height: 37),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _infoHeader(),
                        _myInfo()
                      ],
                    ),
                    SizedBox(height: 60,),
                    CustomButton("비밀변호 변경", CustomButtonType.Default, _onTapPassword(context)),
                    SizedBox(height: 80)
                  ],
                )
            )
        )
    );
  }

  Future<String> _findSessionID() async{
    Preference p = await loadPreference();
    return p.sessionID;
  }

  String userSessionId = "";

  _getSessionId() async{
    _findSessionID().then((String result){
      setState((){
        userSessionId = result;
      });
    });
  }


  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text("마이페이지"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => {Navigator.pop(context)},
        iconSize: 28.0,
        color: Colors.white,
      ),
      centerTitle: true,
    );
  }

  Widget _myNick() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("_currentUser.id", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              InkWell(
                child: Image.asset('assets/mypage_edit.png', width: 30, height: 30,),
                onTap: () {
                  textAlert(context, "닉네임변경", "닉네임을 입력해주세요", "저장하기", this._myNickController, onTap: () {
                    _updateUserNick();
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("아이디", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 30,),
          Text("성별", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 30,),
          Text("생년월일", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
    );
  }

  Widget _myInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("_currentUser.id", style: TextStyle(fontSize: 20)),
          SizedBox(height: 30,),
          Text("_currentUser.gender", style: TextStyle(fontSize: 20)),
          SizedBox(height: 30,),
          Text("_currentUser.birth", style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Widget _nickBtn() {
    return InkWell(
      child: Image.asset('assets/mypage_edit.png', height: 30),
      onTap: () {},
    );
  }



  Future<void> _updateUserNick() async {
    if (this._myNickController.text.isEmpty) {
      alert(context, "닉네임을 다시 입력해주세요.", "확인");
      return;
    }

    bool ok = await _newNick(this._myNickController.text);
    if (ok) {
      FocusScope.of(context).unfocus();
      alert(context, "닉네임이 변경되었습니다.", "확인", onTap: () {
        Navigator.of(context).pop();
      });
    }
  }

  Future<bool> _newNick(String newNick) async {
    try {
      APIClient client = APIClient();
      await client.updateUserNick(newNick);
      return true;
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return false;
        } else if (e.errorCode == APIStatus.Duplicated) {
          alert(context, "중복된 사용자 정보가 존재합니다.", "확인");
          return false;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      return false;
    }
  }



  Function _onTapPassword(BuildContext context) {
    return () async {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => UpdatePassword()));
    };
  }

  Future<User> _findUser(BuildContext context) async {
    try {
      APIClient client = APIClient();
      User currentUser = await client.getUser();
      return currentUser;
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
        } else if (e.errorCode == APIStatus.NotFound) {
          alert(context, "사용자 정보가 존재하지 않습니다.", "확인");
          return null;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return null;
    }
  }
}
