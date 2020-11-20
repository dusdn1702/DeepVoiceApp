import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:deepvoice/view/widget/profileImage.dart';

class MainPage extends StatefulWidget {



  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User _currentUser;

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
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 18),
            children: [
              SizedBox(height: 13.0),
              _mainProfile(),
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
              SizedBox(height: 55)
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xfff2f3f8),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Lv.",
                  style: TextStyle(color: Color(0xff333333), fontSize: 18)),
              Text("21",
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 28,
                      fontWeight: FontWeight.bold))
              //봇레벨은 TTS 구현 후에 추가
            ],
          ),
          SizedBox(height: 12.0),
          Text("QWERTY",
              style: TextStyle(color: Color(0xff333333), fontSize: 24)),
          SizedBox(height: 18),
          Row(
            children: [
              SizedBox(width: 27.5),
              Expanded(child: this._currentUser == null ? Container() : ProfileImage(this._currentUser)),
              SizedBox(width: 27.5)
            ],
          ),
          SizedBox(height: 27),
          Text("레벨"),
          Text("경험치바"),
          Text("경험치")
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
        onPressed: () {},
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
        onPressed: () {},
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
        onPressed: () {},
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
        onPressed: () {},
      ),
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
            Navigator.of(context).popUntil((route) => route.isFirst);
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
}