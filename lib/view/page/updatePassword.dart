import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/textfield.dart';
import 'package:deepvoice/view/widget/button.dart';


class UpdatePassword extends StatefulWidget {

  UpdatePassword();
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _passwordCheckController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: GestureDetector(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: [
              SizedBox(height: 31.0),
              CustomTextField("현재비밀번호", "현재 비밀번호를 입력해 주세요.", TextInputType.text, true, this._oldPasswordController),
              SizedBox(height: 19.0),
              CustomTextField("새비밀번호", "새비밀번호를 입력해주세요.", TextInputType.text, true, this._newPasswordController),
              SizedBox(height: 19.0),
              CustomTextField("비밀번호 확인", "비밀번호를 한번 더 입력해주세요.", TextInputType.text, true, this._passwordCheckController),
              SizedBox(height: 19.0),
              CustomButton("변경하기", CustomButtonType.Default, _onTapNewPassword),
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

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text("비밀번호변경"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => {Navigator.pop(context)},
        iconSize: 28.0,
        color: Colors.white,
      ),
      centerTitle: true,
    );
  }

  Future<void> _onTapNewPassword() async {

    if (this._oldPasswordController.text.isEmpty) {
      alert(context, "비밀번호를 입력해주세요.", "확인");
      return;
    }
    if (this._newPasswordController.text.isEmpty) {
      alert(context, "새 비밀번호를 입력해주세요.", "확인");
      return;
    }
    if (this._newPasswordController.text != this._passwordCheckController.text) {
      alert(context, "새 비밀번호가 일치하지 않습니다.", "확인");
      return;
    }

    bool ok = await _newPassword(this._oldPasswordController.text, this._newPasswordController.text);
    if (ok) {
      FocusScope.of(context).unfocus();
      alert(context, "비밀번호가 변경되었습니다.", "확인", onTap: () {
        Navigator.of(context).pop();
      });
    }
  }

  Future<bool> _newPassword(String oldPw, String newPw) async {
    try {
      APIClient client = APIClient();
      await client.updateUserPassword(oldPw, newPw);
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