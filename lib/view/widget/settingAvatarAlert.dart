import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/bot.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/view/page/login.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';

class SettingAvatarAlert extends StatefulWidget {
  final String alertTitle;
  final AvatarType avatar;
  final String buttonText;

  SettingAvatarAlert(this.alertTitle, this.avatar, this.buttonText);

  @override
  _SettingAvatarAlertState createState() => _SettingAvatarAlertState();
}

class _SettingAvatarAlertState extends State<SettingAvatarAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width - (28.0 * 2.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                const Radius.circular(7.5),
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child:IconButton(
                    icon: const Icon(Icons.close, size: 10),
                    onPressed: () => {Navigator.pop(context)},
                    padding: EdgeInsets.only(top: 19, bottom: 8),
                  ),
                ),
                SizedBox(height: 7.8),
                Text(this.widget.alertTitle, textAlign: TextAlign.center, style: TextStyle(fontSize: 13.8),),
                SizedBox(height: 16.5),
                _settingAvatars(),
                SizedBox(height: 16.5),
                Container(
                  width: double.infinity,
                  child: CustomButton(this.widget.buttonText, CustomButtonType.Default, () async{
                    bool ok = await _updateUserAvatar(context, this.widget.avatar);
                    if (ok) {
                      FocusScope.of(context).unfocus();
                      alert(context, "파일 이름 변경에 성공했습니다.", "확인", onTap: () {
                        Navigator.of(context).pop();
                      });
                    }
                    Navigator.of(context).pop();
                  }),
                ),
                SizedBox(height: 19.5),
              ],
            ),
          )
      ),
    );
  }
  _settingAvatars(){
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _btnRabbit()),
              SizedBox(width: 11.0),
              Expanded(child: _btnDog()),
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(child: _btnBear()),
              SizedBox(width: 11.0),
              Expanded(child: _btnLion()),
              SizedBox(width: 11.0),
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(child: _btnPanda()),
              SizedBox(width: 11.0),
              Expanded(child: _btnCat()),
            ],
          ),
        ],
      ),
    );
  }
  Widget _btnRabbit() {
    return Container(
      child: Column(
        children: [
          _btnAvatar(AvatarType.from(AvatarType.RABBIT).toCircleImage(), this.widget.avatar.isEqualTo(AvatarType.RABBIT), () {
            setState(() {
              this.widget.avatar.set(AvatarType.RABBIT);
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.from(AvatarType.RABBIT).toString()),
        ],
      ),
    );
  }

  Widget _btnDog() {
    return Container(
      child: Column(
        children: [
          _btnAvatar(AvatarType.from(AvatarType.DOG).toCircleImage(), this.widget.avatar.isEqualTo(AvatarType.DOG), () {
            setState(() {
              this.widget.avatar.set(AvatarType.DOG);
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.from(AvatarType.DOG).toString()),
        ],
      ),
    );
  }

  Widget _btnCat() {
    return Container(
      child: Column(
        children: [
          _btnAvatar(AvatarType.from(AvatarType.CAT).toCircleImage(), this.widget.avatar.isEqualTo(AvatarType.CAT), () {
            setState(() {
              this.widget.avatar.set(AvatarType.CAT);
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.from(AvatarType.CAT).toString()),
        ],
      ),
    );
  }

  Widget _btnBear() {
    return Container(
      child: Column(
        children: [
          _btnAvatar(AvatarType.from(AvatarType.BEAR).toCircleImage(), this.widget.avatar.isEqualTo(AvatarType.BEAR), () {
            setState(() {
              this.widget.avatar.set(AvatarType.BEAR);
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.from(AvatarType.BEAR).toString()),
        ],
      ),
    );
  }

  Widget _btnLion() {
    return Container(
      child: Column(
        children: [
          _btnAvatar(AvatarType.from(AvatarType.LION).toCircleImage(), this.widget.avatar.isEqualTo(AvatarType.LION), () {
            setState(() {
              this.widget.avatar.set(AvatarType.LION);
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.from(AvatarType.LION).toString()),
        ],
      ),
    );
  }

  Widget _btnPanda() {
    return Container(
      child: Column(
        children: [
          _btnAvatar(AvatarType.from(AvatarType.PANDA).toCircleImage(), this.widget.avatar.isEqualTo(AvatarType.PANDA), () {
            setState(() {
              this.widget.avatar.set(AvatarType.PANDA);
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.from(AvatarType.PANDA).toString()),
        ],
      ),
    );
  }

  Widget _btnAvatar(Image image, bool isActive, Function onTap) {
    Color borderColor = isActive ? Theme.of(context).primaryColor : Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 4.5),
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        child: image,
        onTap: onTap,
      ),
    );
  }
  Future<bool> _updateUserAvatar(BuildContext context, AvatarType avatarType) async {
    try {
      APIClient client = APIClient();
      await client.updateUserAvatar(avatarType);
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
          alert(context, "사용자 정보가 존재하지 않습니다.", "확인", onTap: () {
            Navigator.of(context).pop();
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

void settingBotAlert(BuildContext context, String alertTitle, AvatarType avatarType, String btnText) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SettingAvatarAlert(alertTitle, avatarType, btnText);
      }
  );
}