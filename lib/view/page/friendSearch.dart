import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/progress.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/model/voice.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/confirm.dart';
import 'package:deepvoice/view/widget/no_data.dart';
import 'package:deepvoice/view/widget/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class FriendSearchPage extends StatefulWidget {
  final Voice voice;
  FriendSearchPage(this.voice);

  @override
  _FriendSearchPageState createState() => _FriendSearchPageState();
}

class _FriendSearchPageState extends State<FriendSearchPage> {
  final _searchController = TextEditingController();
  List<User> _userList = [];
  User _selectedUser;
  int _selectedIndex = -1;

  @override
  void initState() {
    _findFriendList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: GestureDetector(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 13.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Search(this._searchController, (String v) {
                  _findFriendList();
                }),
              ),
              SizedBox(height: 10.0),
              Expanded(child: this._userList.length == 0 ? NoData() : _userListView()),
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
      title: Text("공유하기"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => {Navigator.pop(context)},
        iconSize: 28.0,
        color: Colors.white,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            if (this._selectedUser == null) {
              alert(context, "공유할 친구를 선택해주세요.", "확인");
              return;
            }

            confirm(context, "친구에게 공유하시겠습니까?", "확인", "닫기", () async {
              bool ok = await _addShare();
              if (ok) {
                alert(context, "친구에게 공유되었습니다.", "확인", onTap: () {
                  Navigator.of(context).pop();
                });
              }
            });
          },
          iconSize: 28.0,
          color: Colors.white,
        )
      ],
      centerTitle: true,
    );
  }

  ListView _userListView() {
    return ListView.builder(
      itemCount: this._userList.length,
      itemBuilder: (BuildContext context, int index) {
        return this._friendListItem(index, this._userList[index]);
      }
    );
  }

  Future<void> _findFriendList() async{
    try {
      APIClient client = APIClient();
      List<User> user =  await client.getFriendList(ProgressStatus.from(ProgressStatus.DONE), nick: this._searchController.text);
      setState(() {
        this._selectedUser = null;
        this._selectedIndex = -1;
        this._userList = user;
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
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return;
    }
  }

  Widget _friendListItem(int idx, User friend) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          children: [
            Container(
              height: 65,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              color: this._selectedIndex == idx ? Color(0xfff0e9ff) : Colors.transparent,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: friend.bot.avatar.toCircleImage(),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        width: 140,
                        child: Text(friend.nick, style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ))
                      ),
                    ),
                  ]
              ),),
            Container(
              height: 1,
              width: double.infinity,
              color: Color(0xffcccccc),
            ),
          ],),
      ),
      onTap: () {
        setState(() {
          this._selectedUser = friend;
          this._selectedIndex = idx;
        });
      }
    );
  }

  Future<bool> _addShare() async {
    try {
      APIClient client = APIClient();
      await client.addShare(this.widget.voice.id, this._selectedUser.id);
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
        } else if (e.errorCode == APIStatus.Duplicated) {
          alert(context, "이미 등록된 정보입니다.", "확인");
          return false;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return false;
    }
  }
}