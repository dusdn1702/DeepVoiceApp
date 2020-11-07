import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  final _nickController = TextEditingController();
  final _birthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(child: new Text('회원가입', textAlign: TextAlign.center)),
        leading: new IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Navigator.pop(context)},
          iconSize: 28.0,
          color: const Color(0xFFFFFFFF),
        ),
      ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 18.0),
          Text('  아이디', style: TextStyle(color: Colors.deepPurpleAccent)),
          SizedBox(height: 8.0),
          TextField(
            controller: _usernameController,
            decoration: new InputDecoration(
              enabledBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.white),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(7.0),
                ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.deepPurpleAccent),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(7.0),
                ),
              ),
              filled: true,
              hintText: '아이디를 입력해주세요',
            ),
          ),
          SizedBox(height: 12.0),
          Text('  비밀번호', style: TextStyle(color: Colors.deepPurpleAccent)),
          SizedBox(height: 8.0),
          TextField(
            controller: _passwordController,
            decoration: new InputDecoration(
              enabledBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.white),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(7.0),
                ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.deepPurpleAccent),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(7.0),
                ),
              ),
              filled: true,
              hintText: '비밀번호를 입력해주세요',
            ),
            obscureText: true,
          ),
          SizedBox(height: 12.0),
          Text('  비밀번호 확인', style: TextStyle(color: Colors.deepPurpleAccent)),
          SizedBox(height: 8.0),
          TextField(
            controller: _passwordCheckController,
            decoration: new InputDecoration(
              enabledBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.white),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(7.0),
                ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.deepPurpleAccent),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(7.0),
                ),
              ),
              filled: true,
              hintText: '비밀번호를 한번 더 입력해주세요',
            ),
            obscureText: true,
          ),
          SizedBox(height: 12.0),
          Text('  닉네임', style: TextStyle(color: Colors.deepPurpleAccent)),
          SizedBox(height: 8.0),
          TextField(
            controller: _nickController,
            decoration: new InputDecoration(
              enabledBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.white),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(7.0),
                ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.deepPurpleAccent),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(7.0),
                ),
              ),
              filled: true,
              hintText: '닉네임을 입력해주세요',
            ),
            obscureText: true,
          ),
          SizedBox(height: 12.0),
          Text('  성별', style: TextStyle(color: Colors.deepPurpleAccent)),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0),
                width: 187.0,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  textColor: Colors.deepPurpleAccent,
                  color: Colors.white,
                  child: Text('남성', style: TextStyle(fontSize: 15)),
                  onPressed: () => {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                width: 10.0,
                height: 50.0,
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                width: 187.0,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  textColor: Colors.white,
                  color: Colors.deepPurpleAccent,
                  child: Text('여성', style: TextStyle(fontSize: 15)),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text('  생년월일', style: TextStyle(color: Colors.deepPurpleAccent)),
          SizedBox(height: 8.0),
          TextField(
            controller: _birthController,
            decoration: new InputDecoration(
              enabledBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.white),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(7.0),
                ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.deepPurpleAccent),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(7.0),
                ),
              ),
              filled: true,
              hintText: '생년월일을 입력해주세요 (YYYY-MM-DD)',
            ),
            obscureText: true,
          ),
          SizedBox(height: 12.0),
          Row(
          children: <Widget>[
                Text('  기본 마이봇 설정', style: TextStyle(color: Colors.deepPurpleAccent)),
                new IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => {},
                    iconSize: 30.0,
                    color: Colors.deepPurpleAccent,
                  ),
          ],
          ),
          SizedBox(height: 3.0),
          Row(
              children: <Widget>[
                Text('  한번 선택한 목소리는 수정 ',
                    style: TextStyle(color: Colors.black, fontSize: 13) ),
                Text('불가능',
                    style: TextStyle(color: Colors.red, fontSize: 13) ),
                Text('합니다.',
                    style: TextStyle(color: Colors.black, fontSize: 13) ),
              ]
          ),
          Row(
              children: <Widget>[
                Text('  아바타는 추후 마이페이지에서',
                    style: TextStyle(color: Colors.black, fontSize: 13) ),
                Text('가능',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 13) ),
                Text('합니다.',
                    style: TextStyle(color: Colors.black, fontSize: 13) ),
              ]
          ),
          SizedBox(height: 30.0),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0),
                width: 400.0,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  textColor: Colors.white,
                  color: Colors.deepPurpleAccent,
                  child: Text('회원가입'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
        ],
      )),
    );
  }
}
