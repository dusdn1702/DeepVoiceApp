import 'package:deepvoice/model/bot.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/widget/appbar.dart';
import 'package:deepvoice/view/widget/button.dart';
import 'package:deepvoice/view/widget/search.dart';
import 'package:deepvoice/view/widget/textAlert.dart';
import 'package:deepvoice/view/widget/twoButtonAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendListPage extends StatefulWidget {
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendListPage> {
  String nowButton = "친구목록";
  TextEditingController _friendIdController = TextEditingController();
  List<User> friendList = [];

  @override
  void initState() {
    // _findFriendList().then((List<User> result){
    //   setState(() {
    //     this.friendList = result;
    //   });
    // });
    // super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: GestureDetector(
        child: SafeArea(
          child: Column(
            children: [
              _choosingBar(context),
              SizedBox(height: 13.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Search(),
              ),
              SizedBox(height: 10.0),
              Expanded(child: _selectList(context, nowButton)),
            ],
          )
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      ),
      floatingActionButton: _addFriendButton(context),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text("친구관리"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => {Navigator.pop(context)},
        iconSize: 28.0,
        color: Colors.white,
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _choosingBar(BuildContext context) {
    return Container(
        height: 41.5,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Theme
            .of(context)
            .primaryColor,
        child: Row(
          children: [
            Expanded(
              child: _selectOneColumn("친구목록"),
            ),
            Expanded(
              child: _selectOneColumn("요청받음"),
            ),
            Expanded(
              child:_selectOneColumn("요청보냄"),
            ),
          ],
        )
    );
  }

  Widget _selectList(BuildContext context, String nowButton) {
    if (nowButton == "친구목록"){
      return _friendList(context);}
    else if (nowButton == "요청받음"){
      return _receiveFriendList();}
    else {
      return _sendFriendList(context);
    }
  }

  Widget _selectOneColumn(String oneBox){
    return Column(
      children: [
        Container(
          height: 38.5,
          child: FlatButton(
            child: Text(oneBox,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                nowButton = oneBox;
                _receiveFriendList();
              });
            },
          ),),
        if(nowButton==oneBox)
          Container(
            width: 40,
            height: 3,
            color: Colors.white,
          )
      ],);
  }

  Widget _friendList(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 33,
              width: 33,
              child: AvatarType.from("BEAR").toCircleImage(),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                  child: Text("Friend.name", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ))
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Container(
                width: 20,
                height: 25,
                child: Image.asset("assets/friend_delete.png"),
              ),
              onTap: () {
                print("aaaaa");
                twoButtonAlert(context, "친구를 삭제하시겠습니까?");
              },
            ),
          ],
        ));
  }

  Widget _receiveFriendList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 33,
            width: 33,
            child: AvatarType.from("DOG").toCircleImage(),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Container(
                width: 140,
                child: Text("Friend.name", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ))
            ),
          ),
          SizedBox(width: 110),
          Container(
            child: Row(
                children: [
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      width: 20,
                      height: 25,
                      child: Image.asset("assets/friend_accept.png"),
                    ),
                    onTap: () => {},
                  ),
                  SizedBox(width: 15,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      width: 20,
                      height: 25,
                      child: Image.asset("assets/friend_refuse.png"),
                    ),
                    onTap: () => {},
                  ),
                ]
            ),
          ),
        ]
      ),
    );
  }

  Widget _sendFriendList(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 33,
              width: 33,
              child: AvatarType.from("PANDA").toCircleImage(),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                  child: Text("Friend.name", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ))
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Container(
                width: 20,
                height: 25,
                child: Image.asset("assets/friend_refuse.png"),
              ),
              onTap: () {
                twoButtonAlert(context, "친구요청을 취소하시겠습니까?");
              },
            ),
          ],
        ));
  }

  Widget _addFriendButton(BuildContext context){
    return FloatingActionButton(
        child: Image.asset("assets/friend_add.png"),
        onPressed: () => {
          textAlert(context, "친구추가", "친구의 아이디를 입력하세요", "추가하기", this._friendIdController)
        },
    );
  }
}


