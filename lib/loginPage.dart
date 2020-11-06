import 'package:deep_voice_application/signUpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 100.0),
          Column(
            children: <Widget>[
              Image.asset('assets/login_logo.png'),
            ],
          ),
          SizedBox(height: 50.0),
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
          SizedBox(height: 30.0),
          Column(
            children: <Widget>[
              Container(
                width: 400.0,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  child: Text('로그인'),
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                width: 400.0,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  textColor: Colors.deepPurpleAccent,
                  color: Colors.white,
                  child: Text('회원가입'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Text(
            '아이디/비밀번호 분실 시 \n 010-3304-6302로 문의 바랍니다.',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      )),
    );
  }
}
