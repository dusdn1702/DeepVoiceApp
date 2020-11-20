import 'package:deepvoice/model/voice.dart';
import 'package:deepvoice/view/widget/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SharedListPage extends StatefulWidget {
  _SharedListState createState() => _SharedListState();
}

class _SharedListState extends State<SharedListPage> {
  String nowButton = "요청보냄";
  List<Voice> sharedList = [];

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
                  // child: Search(),
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
              child: _selectOneColumn("요청보냄"),
            ),
            Expanded(
              child: _selectOneColumn("요청받음"),
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
            child: Text(oneBox,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                nowButton = oneBox;
                _sendList(context);
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

  Widget _selectList(BuildContext context, String nowButton) {
    if (nowButton == "요청받음"){
      return _receiveList(context);}
    else if (nowButton == "요청보냄"){
      return _sendList(context);}
  }

  Widget _sendList(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _voiceInfo(),
                _refuseIcon(),
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget _receiveList(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _voiceInfo(),
                  _sharedIcons(),
                ],
              ),
            ),
          ],
        )
    );
  }

  Widget _voiceInfo(){
    return Container(
      height: 53,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("voice.name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 5,),
        Text("user.id", style: TextStyle(fontWeight: FontWeight.normal)),
      ],
    ),
    );
  }

  Widget _refuseIcon(){
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
          onTap: () => {},
        ),
      ],
    );
  }

  Widget _sharedIcons(){
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
          onTap: () => {},
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
          onTap: () => {},
        ),
      ],
    );
  }
}

