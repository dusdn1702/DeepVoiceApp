import 'package:deepvoice/model/bot.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/page/album.dart';
import 'package:deepvoice/view/page/friendList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final String userNick;
  final String userBirth;
  final Gender _gender;
  final AvatarType _avatar;

  SideBar(this.userNick, this._gender, this.userBirth, this._avatar);

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
              _itemOfListTile(context, 'assets/sidemenu_logout.png', '로그아웃', () async{
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => null),);
              },
              ),
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
    return Container(
      width: 75,
      height: 75,
      child: this._avatar.toCircleImage(),
    );
  }

  Widget _userName() {
    return Text(this.userNick,
        style: TextStyle(color: Colors.black, fontSize: 14),
        textAlign: TextAlign.center);
  }

  Widget _userInfo() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            this.userBirth,
            style: TextStyle(color: Colors.black, fontSize: 11.5),
            textAlign: TextAlign.center,
          ),
          Text(
            '세 / ',
            style: TextStyle(color: Colors.black, fontSize: 11.5),
            textAlign: TextAlign.center,
          ),
          Text(
            this._gender.toString(),
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
}
