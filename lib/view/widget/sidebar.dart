import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/bot.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/preference.dart';
import 'package:deepvoice/view/page/album.dart';
import 'package:deepvoice/view/page/friendList.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  final Future<User> _user;

  SideBar(this._user);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SafeArea(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 28.0),
            children: <Widget>[
              _closingIcon(context),
              SizedBox(height: 30.5),
              _userBot(),
              SizedBox(height: 14.3),
              _userName(),
              SizedBox(height: 7),
              _userInfo(),
              SizedBox(height: 43.5),
              _itemOfListTile(context, 'assets/sidemenu_mypage.png', '마이페이지', ()  async{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => null),);
                },
              ),
              SizedBox(height: 7),
              _itemOfListTile(context, 'assets/sidemenu_album.png', '음성앨범', () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumPage()),);
              },
              ),
              SizedBox(height: 7),
              _itemOfListTile(context, 'assets/sidemenu_friend.png', '친구관리', () async{
                Navigator.push(context, MaterialPageRoute(builder: (context) => FriendListPage()),);
              },
              ),
              SizedBox(height: 7),
              _itemOfListTile(context, 'assets/sidemenu_share.png', '공유관리', () async{
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => null),);
              },
              ),
              SizedBox(height: 7),
              _itemOfListTile(context, 'assets/sidemenu_push.png', '푸시관리', () async{
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => null),);
              },
              ),
              SizedBox(height: 155),
              _itemOfListTile(context, 'assets/sidemenu_logout.png', '로그아웃', _onTapLogout(context)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _findUser() async{
    Preference p = await loadPreference();
    return p.sessionID;
  }

  String userSessionId = "";
  _getSessionId() async{
    _findUser().then((String result){
      setState((){
        userSessionId = result;
      });
    });
  }

  User realUser;
  _getUser() async{
    this.widget._user.then((User result){
      setState((){
        realUser = result;
      });
    });
  }

  Widget _closingIcon(BuildContext context) {
    return Container(
      child:
      Align(
        alignment: Alignment.topRight,
        child:IconButton(
          icon: Icon(Icons.close),
          onPressed: () => {Navigator.pop(context)},
          iconSize: 12.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _userBot() {
    _getUser();
    return Container(
      width: 75,
      height: 75,
      child: realUser.bot.avatar.toCircleImage(),
    );
  }

  Widget _userName() {
    _getUser();
    return Text(
      realUser.nick,
        style: TextStyle(color: Colors.black, fontSize: 14),
        textAlign: TextAlign.center);
  }

  Widget _userInfo() {
    _getUser();
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            (DateTime.now().year - realUser.birth.year).toString(),
            style: TextStyle(color: Colors.black, fontSize: 11.5),
            textAlign: TextAlign.center,
          ),
          Text(
            '세 / ',
            style: TextStyle(color: Colors.black, fontSize: 11.5),
            textAlign: TextAlign.center,
          ),
          Text(
            realUser.gender.toString(),
            style: TextStyle(color: Colors.black, fontSize: 11.5),
            textAlign: TextAlign.center,
          ),
        ]);
  }

  Widget _itemOfListTile(BuildContext context, String imageUrl, String titleText, Function onTap) {
    return ListTile(
      leading: Container(
        height: 13,
        width: 11,
        child: Image.asset(imageUrl),
      ),
      title: Text(
        titleText,
        style: TextStyle(fontSize: 10.5, height: 0),
      ),
      onTap: onTap,
    );
  }

  Function _onTapLogout(BuildContext context){
    return () async{
      _getSessionId();
      bool ok = await _logout(context);
      if (ok) {
        FocusScope.of(context).unfocus();
        alert(context, "로그인에 성공했습니다.", "확인", onTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      }
    };
  }

  Future<bool> _logout(BuildContext context) async{
    try {
      APIClient client = APIClient();
      await client.logout(userSessionId);
      return true;
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return false;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return false;
    }
  }

}
