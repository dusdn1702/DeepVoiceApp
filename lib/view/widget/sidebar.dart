import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/page/album.dart';
import 'package:deepvoice/view/page/friendList.dart';
import 'package:deepvoice/view/page/sharedList.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/settingAvatarAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deepvoice/view/page/myPage.dart';

class SideBar extends StatelessWidget {
  final User user;

  SideBar(this.user);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              _closingIcon(context),
              SizedBox(height: 20.5),
              _userProfile(context),
              SizedBox(height: 20.5),
              Expanded(child: this._buttonList(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _closingIcon(BuildContext context) {
    return Container(
      child:
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => {Navigator.pop(context)},
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _userProfile(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Column(
          children: [
            _userBot(context),
            SizedBox(height: 14.3),
            _userName(),
            SizedBox(height: 7),
            _userInfo(),
          ],
        )
    );
  }

  Widget _userBot(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.0,
      height: MediaQuery.of(context).size.width / 3.0,
      child: this.user.bot.avatar.toCircleImage(),
    );
  }

  Widget _userName() {
    return Text(
        this.user.nick,
        style: TextStyle(color: Color(0xff333333), fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }

  Widget _userInfo() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            (DateTime.now().year - this.user.birth.year).toString(),
            textAlign: TextAlign.center,
          ),
          Text(
            '세 / ',
            textAlign: TextAlign.center,
          ),
          Text(
            this.user.gender.toString(),
            textAlign: TextAlign.center,
          ),
        ]);
  }

  Widget _buttonList(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buttonListWithoutLogout(context),
          Column(
            children: [
              _button(context, 'assets/sidemenu_logout.png', '로그아웃', _onTapLogout(context)),
              SizedBox(height: 14.3),
            ],
          )
        ],
      ),
    );
  }

  Widget _buttonListWithoutLogout(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          _button(context, 'assets/sidemenu_mypage.png', '마이페이지', ()  async{
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingAvatarAlert("아바타 설정", this.user.bot.avatar, "변경하기")),);
          },
          ),
          _button(context, 'assets/sidemenu_album.png', '음성앨범', () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumPage()),);
          },
          ),
          _button(context, 'assets/sidemenu_friend.png', '친구관리', () async{
            Navigator.push(context, MaterialPageRoute(builder: (context) => FriendListPage()),);
          },
          ),
          _button(context, 'assets/sidemenu_share.png', '공유관리', () async{
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SharedListPage()),);
          },
          ),
          _button(context, 'assets/sidemenu_push.png', '푸시관리', () async{
              alert(context, "서비스 준비 중입니다.", "닫기");
          },
          ),
        ],
      ),
    );
  }

  Widget _button(BuildContext context, String imageUrl, String titleText, Function onTap) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 50.0,
        alignment: Alignment.center,
        child:  Container(
          child: Row(
            children: [
              Container(
                height: 13,
                width: 11,
                child: Image.asset(imageUrl),
              ),
              SizedBox(width: 34.0),
              Text(titleText),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  Function _onTapLogout(BuildContext context){
    return () async{
      bool ok = await _logout(context);
      if (ok) {
        FocusScope.of(context).unfocus();
        alert(context, "로그아웃 완료", "확인", onTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      }
    };
  }

  Future<bool> _logout(BuildContext context) async{
    try {
      APIClient client = APIClient();
      await client.logout();
      return true;
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return false;
        } else if (e.errorCode == APIStatus.UnknownSession) {
          alert(context, "세션이 만료됐습니다.", "확인", onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
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