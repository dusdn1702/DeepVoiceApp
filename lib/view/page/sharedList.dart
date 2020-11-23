import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/progress.dart';
import 'package:deepvoice/model/share.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/audioPlayer.dart';
import 'package:deepvoice/view/widget/confirm.dart';
import 'package:deepvoice/view/widget/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SharedListPage extends StatefulWidget {
  _SharedListState createState() => _SharedListState();
}

class _SharedListState extends State<SharedListPage> {
  ProgressStatus _status = ProgressStatus.from(ProgressStatus.RECEIVED);
  List<Share> _sharedList = [];

  @override
  void initState() {
    _findShareList(this._status).then((List<Share> result){
      setState(() {
        this._sharedList = result;
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
                ),
                Expanded(child: this._sharedList.length == 0 ? NoData() : _selectList(context)),
              ],
            )
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
      title: Text("공유관리"),
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
              child: _selectOneColumn(ProgressStatus.RECEIVED),
            ),
            Expanded(
              child: _selectOneColumn(ProgressStatus.WAITING),
            ),
          ],
        )
    );
  }

  Widget _selectOneColumn(String oneBox){
    return Column(
      children: [
        Container(
          height: 38.5,
          child: FlatButton(
            child: Text(oneBox == ProgressStatus.WAITING ? "요청보냄" : "요청받음",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                this._findShareList(ProgressStatus.from(oneBox)).then((List<Share> result) {
                  setState(() {
                    this._status.set(oneBox);
                    this._sharedList = result;
                  });
                });
              });
            },
          ),),
        if(this._status.isEqualTo(oneBox))
          Container(
            width: 40,
            height: 3,
            color: Colors.white,
          )
      ],);
  }

  Widget _selectList(BuildContext context) {
    if (this._status.isEqualTo(ProgressStatus.WAITING)) {
      return _sendListView();
    }
    if (this._status.isEqualTo(ProgressStatus.RECEIVED)) {
      return _receiveListView();
    }
  }

  ListView _sendListView() {
    return ListView.builder(
        itemCount: this._sharedList.length,
        itemBuilder: (BuildContext context, int index) {
          return _sendListItem(context, this._sharedList[index]);
        }
    );
  }

  Widget _sendListItem(BuildContext context, Share share) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(child: _voiceInfo(share)),
              _refuseIcon(share),
            ],
          ),
          SizedBox(height: 12.0),
          Container(
            height: 1,
            width: double.infinity,
            color: Color(0xffcccccc),
          ),
        ],
      )
    );
  }

  ListView _receiveListView() {
    return ListView.builder(
        itemCount: this._sharedList.length,
        itemBuilder: (BuildContext context, int index) {
          return _receiveListItem(context, this._sharedList[index]);
        }
    );
  }

  Widget _receiveListItem(BuildContext context, Share share) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(child: _voiceInfo(share)),
                _sharedIcons(share),
              ],
            ),
            SizedBox(height: 12.0),
            Container(
              height: 1,
              width: double.infinity,
              color: Color(0xffcccccc),
            ),
          ],
        )
    );
  }

  Widget _voiceInfo(Share share){
    return InkWell(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(share.voice.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(share.friendNick, style: TextStyle(fontWeight: FontWeight.normal)),
          ],
        ),
      ),
      onTap: () {
        audioPlayer(context, share: share);
      }
    );
  }

  Widget _refuseIcon(Share share){
    return Row(
      children: [
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            height: 53,
            width: 53,
            alignment: Alignment.center,
            child: Container(
              width: 25,
              height: 25,
              child: Image.asset("assets/share_refuse.png"),
            ),
          ),
          onTap: () {
            confirm(context, "공유 요청을 취소하시겠습니까?", "확인", "닫기", () async {
              bool ok = await this._deleteShare(share.id);
              if (ok) {
                alert(context, "공유 요청이 취소되었습니다.", "확인");
                _onRefresh();
              }
            });
          },
        ),
      ],
    );
  }

  Widget _sharedIcons(Share share){
    return Row(
      children: [
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            height: 53,
            width: 53,
            alignment: Alignment.center,
            child: Container(
              width: 25,
              height: 25,
              child: Image.asset("assets/share_accept.png"),
            ),
          ),
          onTap: () {
            confirm(context, "공유 요청을 수락하시겠습니까?", "확인", "닫기", () async {
              bool ok = await this._acceptShare(share.id);
              if (ok) {
                alert(context, "공유 요청이 수락되었습니다.\n해당 음성이 앨범에 추가되었습니다.", "확인");
                _onRefresh();
              }
            });
          },
        ),
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            height: 53,
            width: 53,
            alignment: Alignment.center,
            child: Container(
              width: 25,
              height: 25,
              child: Image.asset("assets/share_refuse.png"),
            ),
          ),
          onTap: () {
            confirm(context, "공유 요청을 거절하시겠습니까?", "확인", "닫기", () async {
              bool ok = await this._denyShare(share.id);
              if (ok) {
                alert(context, "공유 요청이 거절되었습니다.", "확인");
                _onRefresh();
              }
            });
          },
        ),
      ],
    );
  }

  Future<void> _onRefresh() async {
    _findShareList(this._status).then((List<Share> result) {
      setState(() {
        this._sharedList = result;
      });
    });
  }

  Future<List<Share>> _findShareList(ProgressStatus status) async {
    try {
      APIClient client = APIClient();
      return await client.getShareList(status);
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

  Future<bool> _acceptShare(int shareID) async {
    try {
      APIClient client = APIClient();
      await client.acceptShare(shareID);
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

  Future<bool> _denyShare(int shareID) async {
    try {
      APIClient client = APIClient();
      await client.denyShare(shareID);
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

  Future<bool> _deleteShare(int shareID) async {
    try {
      APIClient client = APIClient();
      await client.deleteShare(shareID);
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

