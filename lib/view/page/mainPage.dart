import 'package:deepvoice/view/widget/textAlert.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/sidebar.dart';

import 'login.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User _currentUser;
  bool _progressing = false;

  @override
  void initState() {
    this._findUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBar(),
      endDrawer: this._currentUser == null ? Container() : SideBar(this._currentUser),
      body: GestureDetector(
        child: SafeArea(
          child: _progressing == false ? _body() : Stack(
            children: [
              _body(),
              _convertProgressView(),
            ],
          )
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/main_logo.png',
            fit: BoxFit.contain,
            height: 20,
          )
        ],
      ),
      automaticallyImplyLeading: false,
    );
  }

  Widget _convertProgressView() {
    return Container(
      alignment: Alignment.center,
      color: Color(0xaa000000),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: 60, height: 60, child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor, strokeWidth: 6.0)),
          SizedBox(height: 20.0),
          Text("음성 변환중 입니다.\n잠시만 기다려주세요.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ]
      ),
    );
  }

  Widget _body() {
    return Container(
      color: Color(0xfff2f3f8),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 13.0),
          Expanded(child: _mainProfile()),
          SizedBox(height: 22),
          Row(
            children: [
              Expanded(child: _btnConvert(context)),
              SizedBox(width: 20),
              Expanded(child: _btnLearn(context)),
              SizedBox(width: 20),
              Expanded(child: _btnEmotion(context))
            ],
          ),
          SizedBox(height: 19),
          _btnChat(context),
          SizedBox(height: 19)
        ],
      ),
    );
  }

  Widget _mainProfile() {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: const BorderRadius.all(
          const Radius.circular(7.5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Lv.",
                  style: TextStyle(color: Color(0xff333333), fontSize: 18)),
              Text("1",
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 28,
                      fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(height: 12.0),
          Text(this._currentUser == null ? "" : this._currentUser.nick, style: TextStyle(color: Color(0xff333333), fontSize: 24)),
          SizedBox(height: 18),
          Expanded(
              child: this._currentUser == null ? Container() : Container(
                alignment: Alignment.center,
                child: this._currentUser.bot.avatar.toCircleImage()
              ),
          ),
          SizedBox(height: 27),
          _levelInfo(),
        ],
      ),
    );
  }

  Widget _btnConvert(BuildContext context) {
    return Container(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
          side: BorderSide(color: Theme.of(context).buttonColor, width: 3),
        ),
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 24),
                Expanded(child: Image.asset('assets/main_convert.png')),
                SizedBox(width: 24)
              ],
            ),
            SizedBox(height: 6),
            Text("음성변환",
                style: TextStyle(
                    color: Theme.of(context).buttonColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 15)
          ],
        ),
        color: Colors.white,
        onPressed: () {
          textAlert(context, "음성변환", "변환하고자 하는 텍스트를 입력해주세요.", "변환하기", (String v) async {
            if (v.isEmpty) {
              alert(context, "변환할 텍스트를 입력해주세요.", "확인");
              return;
            }
            setState(() {
              this._progressing = true;
            });
            await this._addVoice(v);
            setState(() {
              this._progressing = false;
            });
          });
        },
      ),
    );
  }

  Widget _btnLearn(BuildContext context) {
    return Container(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
          side: BorderSide(color: Theme.of(context).buttonColor, width: 3),
        ),
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 24),
                Expanded(child: Image.asset('assets/main_learn.png')),
                SizedBox(width: 24)
              ],
            ),
            SizedBox(height: 6),
            Text("학습하기",
                style: TextStyle(
                    color: Theme.of(context).buttonColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 15)
          ],
        ),
        color: Colors.white,
        onPressed: () {
          alert(context, "서비스 준비 중입니다.", "닫기");
        },
      ),
    );
  }

  Widget _btnEmotion(BuildContext context) {
    return Container(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
          side: BorderSide(color: Theme.of(context).buttonColor, width: 3),
        ),
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 24),
                Expanded(child: Image.asset('assets/main_emotionvoice.png')),
                SizedBox(width: 24)
              ],
            ),
            SizedBox(height: 6),
            Text("감정소리",
                style: TextStyle(
                    color: Theme.of(context).buttonColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 15)
          ],
        ),
        color: Colors.white,
        onPressed: () {
          alert(context, "서비스 준비 중입니다.", "닫기");
        },
      ),
    );
  }

  Widget _btnChat(BuildContext context) {
    return Container(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
          side: BorderSide(color: Theme.of(context).buttonColor),
        ),
        child: Column(
          children: [
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  child: Image.asset('assets/main_chat.png'),
                ),
                SizedBox(width: 6),
                Text("채팅하기",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ],

            ),
            SizedBox(height: 14)
          ],
        ),
        onPressed: () {
          alert(context, "서비스 준비 중입니다.", "닫기");
        },
      ),
    );
  }

  Widget _levelInfo() {
    return Container(
      child: Column(
        children: [
          _levelHeader(),
          SizedBox(height: 8.0),
          _levelGage(),
          SizedBox(height: 8.0),
          _levelPercent(),
        ],
      )
    );
  }

  Widget _levelHeader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Lv.1"),
          Text("Lv.2")
        ],
      )
    );
  }

  Widget _levelGage() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 20.0,
          decoration: BoxDecoration(
            color: Color(0xfff0e9ff),
            borderRadius: const BorderRadius.horizontal(
              left: const Radius.circular(10.0),
              right: const Radius.circular(10.0),
            ),
          )
        ),
        Container(
            width: 40.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: Color(0xffaf8eff),
              borderRadius: const BorderRadius.horizontal(
                left: const Radius.circular(10.0),
                right: const Radius.circular(10.0),
              ),
            )
        ),
      ],
    );
  }

  Widget _levelPercent() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("0",
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          Text("%",
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 25)),
          SizedBox(width: 12.0),
          Text("(0/1,000)",
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 20)),
        ],
      )
    );
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

  Future<void> _addVoice(String text) async{
    try {
      APIClient client = APIClient();
      await client.addVoice(text);
      alert(context, "앨범에 저장되었습니다.", "확인");
      return;
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
}