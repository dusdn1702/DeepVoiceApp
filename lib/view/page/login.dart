import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/model/voice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/textfield.dart';
import 'package:deepvoice/view/widget/button.dart';
import 'package:deepvoice/view/page/signup.dart';
import 'package:deepvoice/api/client.dart';

class LoginPage extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            children: <Widget>[
              SizedBox(height: 100.0),
              _logoImage(),
              SizedBox(height: 60.0),
              CustomTextField("아이디", "아이디를 입력해주세요.", TextInputType.text, false, this._usernameController),
              SizedBox(height: 12.0),
              CustomTextField("비밀번호", "비밀번호를 입력해주세요.", TextInputType.text, true, this._passwordController),
              SizedBox(height: 21.0),
              CustomButton("로그인", CustomButtonType.Default, _onTapLogin(context)),
              SizedBox(height: 12.0),
              CustomButton("회원가입", CustomButtonType.Border, _onTapSignUp(context)),
              SizedBox(height: 36.0),
              _lbCaution(),
              SizedBox(height: 36.0),
            ],
          ),
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  Widget _logoImage() {
    return Container(
      width: 112,
      height: 90,
      child: Image.asset('assets/login_logo.png'),
    );
  }

  Widget _lbCaution() {
    return Text(
      '아이디/비밀번호 분실 시 \n 010-3304-6302로 문의 바랍니다.',
      style: TextStyle(color: Color(0xff666666)),
      textAlign: TextAlign.center,
    );
  }

  Function _onTapSignUp(BuildContext context) {
    return () async {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
    };
  }

  Function _onTapLogin(BuildContext context) {
    return () async {
      if (this._usernameController.text.isEmpty) {
        alert(context, "아이디를 입력해주세요.", "확인");
        return;
      }
      if (this._passwordController.text.isEmpty) {
        alert(context, "비밀번호를 입력해주세요.", "확인");
        return;
      }

      bool ok = await _login(context, this._usernameController.text, this._passwordController.text);
      if (ok) {
        FocusScope.of(context).unfocus();
        alert(context, "로그인에 성공했습니다.\n메인 서비스 준비중입니다.", "확인");
      }
    };
  }

  Future<bool> _login(BuildContext context, String id, String password) async {
    try {
      APIClient client = APIClient();
      await client.login(id, password);
      return true;
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return false;
        } else if (e.errorCode == APIStatus.IncorrectCredential) {
          alert(context, "아이디 또는 비밀번호가 일치하지 않습니다.", "확인");
          return false;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return false;
    }
  }
}
