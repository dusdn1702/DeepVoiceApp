import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/progress.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/confirm.dart';
import 'package:deepvoice/view/widget/no_data.dart';
import 'package:deepvoice/view/widget/textAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class FriendListPage extends StatefulWidget {
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendListPage> {
  String nowButton = ProgressStatus.DONE;
  TextEditingController _friendIdController = TextEditingController();
  List<User> friendList = [];

  @override
  void initState() {
    _findFriendList(ProgressStatus.DONE).then((List<User> result) {
      setState(() {
        this.friendList = result;
      });
    });
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
                _choosingBar(context),
                SizedBox(height: 13.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  // child: Search(),
                ),
                SizedBox(height: 10.0),
                Expanded(child: this.friendList.length == 0 ? NoData() : _selectList(context, nowButton)),
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
      backgroundColor: Theme
          .of(context)
          .primaryColor,
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
              child: _selectOneColumn(ProgressStatus.DONE),
            ),
            Expanded(
              child: _selectOneColumn(ProgressStatus.WAITING),
            ),
            Expanded(
              child: _selectOneColumn(ProgressStatus.RECEIVED),
            ),
          ],
        )
    );
  }

  Future<List<User>> _findFriendList(String status) async {
    ProgressStatus progressStatus = new ProgressStatus.from(status);
    try {
      APIClient client = APIClient();
      return await client.getFriendList(progressStatus);
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return null;
        } else if (e.errorCode == APIStatus.UnknownSession) {
          alert(context, "세션이 만료됐습니다.", "확인", onTap: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
          });
          return null;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return null;
    }
  }

  ListView _friendListView() {
    return ListView.builder(
        itemCount: this.friendList.length,
        itemBuilder: (BuildContext context, int index) {
          return _friendListItem(context, this.friendList[index]);
        }
    );
  }

  ListView _sendFriendListView() {
    return ListView.builder(
        itemCount: this.friendList.length,
        itemBuilder: (BuildContext context, int index) {
          return _sendFriendListItem(context, this.friendList[index]);
        }
    );
  }

  ListView _receiveFriendListView() {
    return ListView.builder(
        itemCount: this.friendList.length,
        itemBuilder: (BuildContext context, int index) {
          return _receiveFriendListItem(context, this.friendList[index]);
        }
    );
  }

  Widget _selectList(BuildContext context, String nowButton) {
    if (nowButton == ProgressStatus.DONE) {
      return _friendListView();
    }
    else if (nowButton == ProgressStatus.WAITING) {
      return _sendFriendListView();
    }
    else {
      return _receiveFriendListView();
    }
  }

  Widget _selectOneColumn(String oneBox) {
    String oneBoxName = _getFriendName(oneBox);
    return Column(
      children: [
        Container(
          height: 38.5,
          child: FlatButton(
            child: Text(oneBoxName,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _findFriendList(oneBox).then((List<User> result) {
                setState(() {
                  this.nowButton = oneBox;
                  this.friendList = result;
                });
              });
            },
          ),),
        if(this.nowButton == oneBox)
          Container(
            width: 43,
            height: 3,
            color: Colors.white,
          )
      ],);
  }

  Widget _friendListItem(BuildContext context, User friend) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(
        children: [
          Container(
            height: 65,
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
                              child: Image.asset("assets/friend_delete.png"),
                            ),
                            onTap: () {
                              confirm(context, "친구를 삭제하시겠습니까?", "확인", "닫기", () async {
                                bool ok = await _onTapDeleteFriend(friend.id);
                                if (ok) {
                                  alert(context, "친구가 삭제되었습니다.", "확인");
                                  _onRefresh();
                                }
                              });
                            },
                          ),
                        ]
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
    );
  }

  Widget _receiveFriendListItem(BuildContext context, User friend) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(
        children: [
          Container(
            height: 65,
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
                          onTap: () {
                            confirm(context, "친구 요청을 수락하시겠습니까?", "확인", "닫기", () async {
                              bool ok = await _onTapAcceptFriend(friend.id);
                              if (ok) {
                                alert(context, "친구 요청이 수락되었습니다.", "확인");
                                _onRefresh();
                              }
                            });
                          },
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
                          onTap: () {
                            confirm(context, "친구 요청을 거절하시겠습니까?", "확인", "닫기", () async {
                              bool ok = await _onTapDeleteFriend(friend.id);
                              if (ok) {
                                alert(context, "친구 요청이 거절되었습니다.", "확인");
                                _onRefresh();
                              }
                            });
                          },
                        ),
                      ]
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
    );
  }

  Widget _sendFriendListItem(BuildContext context, User friend) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(
        children: [
          Container(
            height: 65,
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
                              child: Image.asset("assets/friend_refuse.png"),
                            ),
                            onTap: () {
                              confirm(context, "친구 요청을 취소하시겠습니까?", "확인", "닫기", () async {
                                bool ok = await _onTapDeleteFriend(friend.id);
                                if (ok) {
                                  alert(context, "친구 요청이 취소되었습니다.", "확인");
                                  _onRefresh();
                                }
                              });
                            },
                          ),
                        ]
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
    );
  }

  Widget _addFriendButton(BuildContext context) {
    return FloatingActionButton(
      child: Image.asset("assets/friend_add.png"),
      onPressed: () {
        textAlert(context, "친구요청", "친구 요청할 아이디를 입력해주세요.", "추가하기",
          this._friendIdController, onTap: () async {
            String v = this._friendIdController.text;
            this._friendIdController.clear();
            bool ok = await _onTapAddFriend(v);
            if (ok) {
              FocusScope.of(context).unfocus();
              alert(context, "친구 요청이 완료되었습니다.", "확인");
              this.nowButton = ProgressStatus.WAITING;
              _onRefresh();
            }
          });
      },
    );
  }

  Future<void> _onRefresh() async {
    _findFriendList(this.nowButton).then((List<User> result) {
      setState(() {
        this.friendList = result;
      });
    });
  }

  Future<bool> _onTapAddFriend(String friendID) async {
    try {
      APIClient client = APIClient();
      await client.addFriend(friendID);
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
          alert(context, "존재하지 않는 아이디입니다.", "확인");
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

  Future<bool> _onTapAcceptFriend(int friendID) async {
    try {
      APIClient client = APIClient();
      await client.acceptFriend(friendID);
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
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return false;
    }
  }

  Future<bool> _onTapDeleteFriend(int friendID) async {
    try {
      APIClient client = APIClient();
      await client.deleteFriend(friendID);
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
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return false;
    }
  }
}

String _getFriendName(String oneBox) {
  if (oneBox == ProgressStatus.DONE) {
    return "친구목록";
  } else if (oneBox == ProgressStatus.RECEIVED) {
    return "요청받음";
  } else if (oneBox == ProgressStatus.WAITING) {
    return "요청보냄";
  }else return null;
}



