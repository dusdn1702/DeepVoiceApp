import 'package:deepvoice/model/bot.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/widget/appbar.dart';
import 'package:deepvoice/view/widget/button.dart';
import 'package:deepvoice/view/widget/search.dart';
import 'package:deepvoice/view/widget/textAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendListPage extends StatefulWidget {
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendListPage> {
  String nowButton = "친구목록";
  TextEditingController _friendIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: GestureDetector(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 0),
            children: [
              _choosingBar(context),
              SizedBox(height: 13.0),
              //Search(),
              SizedBox(height: 10.0),
              _selectList(context, nowButton),
              _addFriendButton(context),
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
      title: Text("친구관리", style: TextStyle(fontSize: 11),),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 12.3,),
        onPressed: () => {Navigator.pop(context)},
        iconSize: 28.0,
        color: Colors.white,
      ),
      centerTitle: true,
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
            Expanded(child: RaisedButton(
              child: Text("친구목록",
              style: TextStyle(color: Colors.white, fontSize: 9.5),
            ),
              onPressed: () {
                setState(() {
                  nowButton = "친구목록";
                  _friendList(context);
                });
            },
            ),),
            Expanded(child: RaisedButton(
              child: Text("요청받음",
                style: TextStyle(color: Colors.white, fontSize: 9.5),
              ),
              onPressed: () {
                setState(() {
                  nowButton = "요청받음";
                  _receiveFriendList();
                });
              },
            ),),
            Expanded(child: RaisedButton(
              child: Text("요청보냄",
                style: TextStyle(color: Colors.white, fontSize: 9.5),
              ),
              onPressed: () {
                setState(() {
                  nowButton = "요청보냄";
                  _sendFriendList(context);
                });
              },
            ),),
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

  Widget _friendList(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          leading: Container(
            height: 33,
            width: 33,
            child: AvatarType.from("BEAR").toCircleImage(),
          ),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text("Friend.name", style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ))
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: 12,
                  child: Image.asset("assets/friend_delete.png"),),
              ]
          ),
      onTap: () {

      },
    ));
  }

  Widget _receiveFriendList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: ListTile(
        leading: Container(
          height: 33,
          width: 33,
          child: AvatarType.from("DOG").toCircleImage(),
        ),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 140,
                  child: Text("Friend.name", style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ))
              ),
              SizedBox(width: 110),
              InkWell(
                child: Container(
                width: 11.5,
                height: 13.3,
                child: Image.asset("assets/friend_accept.png"),
                ),
                onTap: () => {},
              ),
              SizedBox(width: 17,),
              InkWell(
                child: Container(
                  width: 11.5,
                  height: 13.3,
                  child: Image.asset("assets/friend_refuse.png"),
                ),
                onTap: () => {},
              ),
            ]),),
    );
  }

  Widget _sendFriendList(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
    width: MediaQuery
        .of(context)
        .size
        .width,
    child: ListTile(
      leading: Container(
        height: 33,
        width: 33,
        child: AvatarType.from("PANDA").toCircleImage(),
      ),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 160,
                child: Text("Friend.name", style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ))
            ),
            SizedBox(width: 17,),
            InkWell(
              child: Container(
                width: 11.5,
                height: 13.3,
                child: Image.asset("assets/friend_refuse.png"),
              ),
              onTap: () => {
                _twoButtonAlert("친구 요청을 취소하시겠습니까?", context)
              },
            ),
          ]
      ),),
    );
  }

  Widget _twoButtonAlert(String alertTitle, BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery
                .of(context)
                .size
                .width - (28.0 * 2.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                const Radius.circular(7.5),
              ),
            ),
            child: Column(
              children: [
                Text(alertTitle, textAlign: TextAlign.center),
                SizedBox(height: 21.5),
                Row(
                    children: [
                      Container(
                        width: double.infinity,
                        child: CustomButton(
                            "확인", CustomButtonType.Positive, () {
                          Navigator.of(context).pop();
                          //여기서 친구 요청 취소 함수
                        }),
                      ),
                      SizedBox(width: 29.5),
                      Container(
                        width: double.infinity,
                        child: CustomButton(
                            "닫기", CustomButtonType.Negative, () {
                          Navigator.of(context).pop();
                        }),
                      ),
                    ]),
                SizedBox(height: 16),
              ],
            ),
          )
      ),
    );
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

