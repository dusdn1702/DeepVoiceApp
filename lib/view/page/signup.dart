import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';
import 'package:deepvoice/view/widget/textfield.dart';
import 'package:deepvoice/model/bot.dart';
import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/page/setting_bot.dart';
import 'package:deepvoice/view/widget/alert.dart';

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
  Gender _gender = Gender.from(Gender.MAN);
  AvatarType _avatar = AvatarType.from(AvatarType.RABBIT);
  VoiceType _voice = VoiceType.from(VoiceType.MAN1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: GestureDetector(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: [
              SizedBox(height: 23.0),
              CustomTextField("아이디", "아이디를 입력해주세요.", TextInputType.text, false, this._usernameController),
              SizedBox(height: 19.0),
              CustomTextField("비밀번호", "비밀번호를 입력해주세요.", TextInputType.text, true, this._passwordController),
              SizedBox(height: 19.0),
              CustomTextField("비밀번호 확인", "비밀번호를 한번 더 입력해주세요.", TextInputType.text, true, this._passwordCheckController),
              SizedBox(height: 19.0),
              CustomTextField("닉네임", "닉네임을 입력해주세요.", TextInputType.text, false, this._nickController),
              SizedBox(height: 19.0),
              _btnGender(),
              SizedBox(height: 19.0),
              CustomTextField("생년월일", "생년월일을 입력해주세요. (YYYYMMDD)", TextInputType.number, false, this._birthController),
              SizedBox(height: 19.0),
              _settingBot(),
              SizedBox(height: 15.0),
              CustomButton("회원가입", CustomButtonType.Default, _onTapSignUp),
              SizedBox(height: 25.0),
            ],
          ),
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("회원가입"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => {Navigator.pop(context)},
        iconSize: 28.0,
        color: Colors.white,
      ),
      centerTitle: true,
    );
  }

  Widget _btnGender() {
    return Container(
      child: Row(
        children: [
          Expanded(child: _btnMan()),
          SizedBox(width: 10.0),
          Expanded(child: _btnWoman()),
        ],
      ),
    );
  }

  Widget _btnMan() {
    String text = Gender.from(Gender.MAN).toString();
    Function onTap = () {
      setState(() {
        this._gender.set(Gender.MAN);
      });
    };
    if (this._gender.isEqualTo(Gender.MAN)) {
      return CustomButton(text, CustomButtonType.Default, onTap);
    } else {
      return CustomButton(text, CustomButtonType.Border, onTap);
    }
  }

  Widget _btnWoman() {
    String text = Gender.from(Gender.WOMAN).toString();
    Function onTap = () {
      setState(() {
        this._gender.set(Gender.WOMAN);
      });
    };
    if (this._gender.isEqualTo(Gender.WOMAN)) {
      return CustomButton(text, CustomButtonType.Default, onTap);
    } else {
      return CustomButton(text, CustomButtonType.Border, onTap);
    }
  }

  Widget _settingBot() {
    return Container(
      child: Column(
        children: [
          _settingBotHeader(),
          SizedBox(height: 8.0),
          Row(children: [
            Text("한번 선택한 목소리는 수정 ", style: TextStyle(color: Color(0xff666666), fontSize: 13)),
            Text("불가능", style: TextStyle(color: Theme.of(context).errorColor, fontSize: 13)),
            Text("합니다.", style: TextStyle(color: Color(0xff666666), fontSize: 13)),
          ]),
          Row(children: [
            Text("아바타는 추후 마이페이지에서 ", style: TextStyle(color: Color(0xff666666), fontSize: 13)),
            Text("가능", style: TextStyle(color: Theme.of(context).accentColor, fontSize: 13)),
            Text("합니다.", style: TextStyle(color: Color(0xff666666), fontSize: 13)),
          ]),
          SizedBox(height: 16.0),
          _settingBotBody(),
        ],
      ),
    );
  }

  Widget _settingBotHeader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("기본 마이봇 설정", style: TextStyle(color: Theme.of(context).primaryColor)),
          _btnSettingBot(),
        ],
      ),
    );
  }

  Widget _btnSettingBot() {
    return InkWell(
      child: Container(
        width: 28.5,
        height: 28.5,
        child: Image.asset('assets/signup_setting.png'),
      ),
      onTap: _onTapSettingBot,
    );
  }

  void _onTapSettingBot() async{
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => SettingBotPage(_avatar, _voice, (AvatarType a, VoiceType v) {
        setState(() {
          _avatar = a;
          _voice = v;
        });
      })),
    );
  }

  Widget _settingBotBody() {
    return  Container(
      padding: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Color(0xfff3f5fa),
        borderRadius: const BorderRadius.all(
          const Radius.circular(7.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            child: this._avatar.toCircleImage(),
          ),
          SizedBox(width: 30.0),
          Text(this._voice.toString()),
        ],
      ),
    );
  }

  Future<void> _onTapSignUp() async {
    if (this._usernameController.text.isEmpty) {
      alert(context, "아이디를 입력해주세요.", "확인");
      return;
    }
    if (this._passwordController.text.isEmpty) {
      alert(context, "비밀번호를 입력해주세요.", "확인");
      return;
    }
    if (this._passwordCheckController.text.isEmpty) {
      alert(context, "비밀번호를 한번 더 입력해주세요.", "확인");
      return;
    }
    if (this._passwordController.text != this._passwordCheckController.text) {
      alert(context, "비밀번호가 일치하지 않습니다.", "확인");
      return;
    }
    if (this._nickController.text.isEmpty) {
      alert(context, "닉네임을 입력해주세요.", "확인");
      return;
    }
    if (this._birthController.text.isEmpty) {
      alert(context, "생년월일을 입력해주세요.", "확인");
      return;
    }
    if (this._birthController.text.length != 8) {
      alert(context, "생년월일을 형식에 맞게 입력해주세요.", "확인");
      return;
    }

    bool ok = await _signUp(this._usernameController.text, this._passwordController.text, this._nickController.text, this._gender.get(), this._birthController.text, this._avatar.get(), this._voice.get());
    if (ok) {
      FocusScope.of(context).unfocus();
      alert(context, "회원가입이 완료 되었습니다.\n로그인 후 이용해주세요.", "확인", onTap: () {
        Navigator.of(context).pop();
      });
    }
  }

  Future<bool> _signUp(String id, String pw, String nick, String gender, String birth, String avatar, String voice) async {
    try {
      APIClient client = APIClient();
      await client.signUp(id, pw, nick, gender, birth, avatar, voice);
      return true;
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return false;
        } else if (e.errorCode == APIStatus.Duplicated) {
          alert(context, "중복된 사용자 정보가 존재합니다.", "확인");
          return false;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      return false;
    }
  }
}
