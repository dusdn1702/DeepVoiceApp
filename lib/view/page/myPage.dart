import 'package:deepvoice/model/bot.dart';
import 'package:deepvoice/view/page/updatePassword.dart';
import 'package:deepvoice/view/widget/profileImage.dart';
import 'package:deepvoice/view/widget/settingAvatarAlert.dart';
import 'package:deepvoice/view/widget/textAlert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:deepvoice/view/widget/button.dart';
import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/widget/alert.dart';

import 'login.dart';

class MyPage extends StatefulWidget {
  final Function onMainRefresh;

  MyPage(this.onMainRefresh);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  User _currentUser;

  @override
  void initState() {
    this._findUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: GestureDetector(
            child: SafeArea(
                child: Container(
                    child: ListView(
                      children: [
                        SizedBox(height: 29),
                        Center(
                          child: this._currentUser == null
                              ? Container(width: MediaQuery.of(context).size.width - (48.0 * 2.0), height: MediaQuery.of(context).size.width - (48.0 * 2.0))
                              : ProfileImage(this._currentUser, MediaQuery.of(context).size.width - (48.0 * 2.0), () {
                              settingBotAlert(context, this._currentUser.bot.avatar.get(), (AvatarType avatar) async {
                                bool ok = await _updateAvatar(context, avatar);
                                if (ok) {
                                  alert(context, "아바타가 변경되었습니다.", "확인");
                                  this._findUser(context);
                                  this.widget.onMainRefresh();
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 37),
                        _info(),
                        SizedBox(height: 52),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 22.0),
                          child: CustomButton("비밀변호 변경", CustomButtonType.Default, _onTapPassword(context)),
                        ),
                        SizedBox(height: 20)
                      ],
                    )
                )
            )
        )
    );
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

  Widget _info() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 37),
      child: Column(
        children: [
          _myNick(),
          SizedBox(height: 34),
          _myId(),
          SizedBox(height: 30),
          _myGender(),
          SizedBox(height: 30),
          _myBirth()
        ]
      ),
    );
  }

  Widget _myNick() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(this._currentUser == null ? "" : this._currentUser.nick ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
              SizedBox(width: 20.0),
              InkWell(
                child: Image.asset('assets/mypage_edit.png', width: 30, height: 30),
                onTap: () {
                  textAlert(context, "닉네임변경", "닉네임을 입력해주세요.", "저장하기", (String v) async {
                    if (v.isEmpty) {
                      alert(context, "닉네임을 입력해주세요.", "확인");
                      return;
                    }

                    bool ok = await _newNick(v);
                    if (ok) {
                      FocusScope.of(context).unfocus();
                      alert(context, "닉네임이 변경되었습니다.", "확인");
                      this._findUser(context);
                      this.widget.onMainRefresh();
                    }
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }


  Widget _myId() {
    return Container(
        width: double.infinity,
        child: Container(
          child: Row(
            children: [
              Container(
                width: 100.0,
                child: Text("아이디", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Text(this._currentUser == null ? "" : this._currentUser.loginID, style: TextStyle(fontSize: 20))
            ],
          ),
        )
    );
  }

  Widget _myGender() {
    return Container(
        width: double.infinity,
        child: Container(
          child: Row(
            children: [
              Container(
                width: 100,
                child: Text("성별", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Text(this._currentUser == null ? "" : this._currentUser.gender.toString(), style: TextStyle(fontSize: 20))
            ],
          ),
        )
    );
  }

  Widget _myBirth() {
    return Container(
        width: double.infinity,
        child: Container(
          child: Row(
            children: [
              Container(
                width: 100,
                child: Text("생년월일", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Text(this._currentUser == null ? "" : this._currentUser.birthToString(), style: TextStyle(fontSize: 20)),
            ],
          ),
        )
    );
  }

  Future<bool> _newNick(String nick) async {
    try {
      APIClient client = APIClient();
      await client.updateUserNick(nick);
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
    return () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => UpdatePassword()),
      );
    };
  }

  Future<void> _findUser(BuildContext context) async {
    try {
      APIClient client = APIClient();
      User user = await client.getUser();
      setState(() {
        this._currentUser = user;
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
        } else if (e.errorCode == APIStatus.NotFound) {
          alert(context, "사용자 정보가 존재하지 않습니다.", "확인");
          return;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return;
    }
  }

  Future<bool> _updateAvatar(BuildContext context, AvatarType avatar) async {
    try {
      APIClient client = APIClient();
      await client.updateUserAvatar(avatar);
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
          alert(context, "사용자 정보가 존재하지 않습니다.", "확인");
          return false;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return false;
    }
  }
}