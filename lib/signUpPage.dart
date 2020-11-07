import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deep_voice_application/basicMyBotSettingPage.dart';

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
  String _gender = "M";
  String _voice = "";
  String _avatar = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        leading: new IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Navigator.pop(context)},
          iconSize: 28.0,
          color: const Color(0xFFFFFFFF),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 18.0),
          _idText(),
          SizedBox(height: 8.0),
          _tfId(),
          SizedBox(height: 12.0),
          _pwText(),
          SizedBox(height: 8.0),
          _tfPw(),
          SizedBox(height: 12.0),
          _pwCheckText(),
          SizedBox(height: 8.0),
          _tfPwCheck(),
          SizedBox(height: 12.0),
          _nickText(),
          SizedBox(height: 8.0),
          _tfNick(),
          SizedBox(height: 12.0),
          _genderText(),
          // _genderButton(),
          Row(
            children: <Widget>[
              Expanded(child: _manButton()),
              Expanded(child: _womanButton()),
            ],
          ),
          SizedBox(height: 12.0),
          _birthText(),
          SizedBox(height: 8.0),
          _tfBirth(),
          SizedBox(height: 12.0),
          Row(
            children: <Widget>[
              _myBotSettingText(),
              _settingIcon(),
            ],
          ),
          SizedBox(height: 3.0),
          _impossibleText(),
          _possibleText(),
          SizedBox(height: 15.0),
          _botInfo(),
          SizedBox(height: 15.0),
          _signUpButton(),
          SizedBox(height: 30.0),
        ],
      )),
    );
  }

  Widget _appBar(){
    return Container(
    );
  }

  Widget _appBarText() {
    return Text('회원가입', textAlign: TextAlign.center);
  }

  Widget _appBarIcon(){
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => {Navigator.pop(context)},
      iconSize: 28.0,
      color: const Color(0xFFFFFFFF),
    );
  }

  Widget _idText() {
    return Text('  아이디', style: TextStyle(color: Colors.deepPurpleAccent));
  }

  Widget _tfId() {
    return TextField(
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
    );
  }

  Widget _pwText() {
    return Text('  비밀번호', style: TextStyle(color: Colors.deepPurpleAccent));
  }

  Widget _tfPw() {
    return TextField(
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
    );
  }

  Widget _pwCheckText() {
    return Text('  비밀번호 확인', style: TextStyle(color: Colors.deepPurpleAccent));
  }

  Widget _tfPwCheck() {
    return TextField(
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
    );
  }

  Widget _nickText() {
    return Text('  닉네임', style: TextStyle(color: Colors.deepPurpleAccent));
  }

  Widget _tfNick() {
    return TextField(
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
    );
  }

  Widget _genderText() {
    return Text('  성별', style: TextStyle(color: Colors.deepPurpleAccent));
  }

  Widget _manButton() {
    return Container(
      margin: EdgeInsets.only(top: 6, right: 8),
      height: 50.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
          side: BorderSide(color: Color(0xFF8b80f9)),
        ),
        textColor: (_gender == "M") ? Colors.white : Colors.deepPurpleAccent,
        color: (_gender == "M") ? Colors.deepPurpleAccent : Colors.white,
        child: Text('남성', style: TextStyle(fontSize: 15)),
        onPressed: () => {
          setState(() {
            _gender = "M";
          })
        },
      ),
    );
  }

  Widget _womanButton() {
    return Container(
      margin: EdgeInsets.only(top: 6.0),
      height: 50.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
          side: BorderSide(color: Colors.deepPurpleAccent),
        ),
        textColor: (_gender == "W") ? Colors.white : Colors.deepPurpleAccent,
        color: (_gender == "W") ? Colors.deepPurpleAccent : Colors.white,
        child: Text('여성', style: TextStyle(fontSize: 15)),
        onPressed: () => {
          setState(() {
            _gender = "W";
          })
        },
      ),
    );
  }

  Widget _birthText() {
    return Text('  생년월일', style: TextStyle(color: Colors.deepPurpleAccent));
  }

  Widget _tfBirth() {
    return TextField(
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
    );
  }

  Widget _myBotSettingText() {
    return Text('  기본 마이봇 설정',
        style: TextStyle(color: Colors.deepPurpleAccent));
  }

  Widget _settingIcon() {
    return InkWell(
      child: Container(
          child: Image.asset('assets/signup_setting.png',
              width: 28.5, height: 28.5),
          margin: EdgeInsets.only(left: 231.5)),
      onTap: () => {
        Navigator.push(
        context, MaterialPageRoute(builder: (context) => BasicMyBotSettingPage((String a, String v) {
          setState(() {
            _avatar = a;
            _voice = v;
          });
        })),
        ),
      },
    );
  }

  Widget _impossibleText() {
    return Row(children: <Widget>[
      Text('  한번 선택한 목소리는 수정 ',
          style: TextStyle(color: Colors.black, fontSize: 13)),
      Text('불가능', style: TextStyle(color: Colors.red, fontSize: 13)),
      Text('합니다.', style: TextStyle(color: Colors.black, fontSize: 13)),
    ]);
  }

  Widget _possibleText() {
    return Row(children: <Widget>[
      Text('  아바타는 추후 마이페이지에서',
          style: TextStyle(color: Colors.black, fontSize: 13)),
      Text('가능', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
      Text('합니다.', style: TextStyle(color: Colors.black, fontSize: 13)),
    ]);
  }

  Widget _botInfo() {
    return  Container(
      height: 63.0,
      decoration: BoxDecoration(
        color: Color(0xfff3f5fa),
        borderRadius: const BorderRadius.all(
          const Radius.circular(7.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_avatarToString(this._avatar), style: TextStyle(color: Colors.black, fontSize: 20)),
          SizedBox(width: 30.0),
          Text(_voiceToString(this._voice), style: TextStyle(color: Colors.black, fontSize: 20)),
        ],
      ),
    );
  }

  String _avatarToString(String v) {
    if (v == "RABBIT") {
      return "토끼";
    }
    if (v == "DOG") {
      return "개";
    }
    if (v == "CAT") {
      return "고양이";
    }
    if (v == "BEAR") {
      return "곰";
    }
    if (v == "LION") {
      return "사자";
    }
    if (v == "PANDA") {
      return "판다";
    }

    return "";
  }

  String _voiceToString(String v) {
    if (v == "M1") {
      return "남성1";
    }
    if (v == "M2") {
      return "남성2";
    }
    if (v == "W1") {
      return "여성1";
    }
    if (v == "W2") {
      return "여성2";
    }

    return "";
  }

  Widget _signUpButton() {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
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
    );
  }
}
