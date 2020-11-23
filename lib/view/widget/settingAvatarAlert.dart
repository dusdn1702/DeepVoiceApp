import 'package:deepvoice/model/bot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';

class SettingAvatarAlert extends StatefulWidget {
  final String avatarType;
  final Function(AvatarType) onTap;

  SettingAvatarAlert(this.avatarType, this.onTap);

  @override
  _SettingAvatarAlertState createState() => _SettingAvatarAlertState();
}

class _SettingAvatarAlertState extends State<SettingAvatarAlert> {
  AvatarType _avatar = AvatarType.from(AvatarType.RABBIT);

  @override
  void initState() {
    this._avatar = AvatarType.from(this.widget.avatarType);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
          child: Container(
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
                    icon: const Icon(Icons.close),
                    onPressed: () => {Navigator.pop(context)},
                    padding: EdgeInsets.only(top: 10),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      Text("아바타 설정", textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
                      SizedBox(height: 16.5),
                      _settingAvatars(),
                      SizedBox(height: 16.5),
                      Container(
                        width: double.infinity,
                        child: CustomButton("변경하기", CustomButtonType.Default, () {
                          Navigator.of(context).pop();
                          this.widget.onTap(this._avatar);
                        }),
                      ),
                    ],
                  )
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
          _btnAvatar(AvatarType.from(AvatarType.RABBIT).toCircleImage(), this._avatar.isEqualTo(AvatarType.RABBIT), () {
            setState(() {
              this._avatar.set(AvatarType.RABBIT);
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
          _btnAvatar(AvatarType.from(AvatarType.DOG).toCircleImage(), this._avatar.isEqualTo(AvatarType.DOG), () {
            setState(() {
              this._avatar.set(AvatarType.DOG);
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
          _btnAvatar(AvatarType.from(AvatarType.CAT).toCircleImage(), this._avatar.isEqualTo(AvatarType.CAT), () {
            setState(() {
              this._avatar.set(AvatarType.CAT);
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
          _btnAvatar(AvatarType.from(AvatarType.BEAR).toCircleImage(), this._avatar.isEqualTo(AvatarType.BEAR), () {
            setState(() {
              this._avatar.set(AvatarType.BEAR);
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
          _btnAvatar(AvatarType.from(AvatarType.LION).toCircleImage(), this._avatar.isEqualTo(AvatarType.LION), () {
            setState(() {
              this._avatar.set(AvatarType.LION);
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
          _btnAvatar(AvatarType.from(AvatarType.PANDA).toCircleImage(), this._avatar.isEqualTo(AvatarType.PANDA), () {
            setState(() {
              this._avatar.set(AvatarType.PANDA);
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
}

void settingBotAlert(BuildContext context, String avatarType, Function(AvatarType) onTap) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SettingAvatarAlert(avatarType, onTap);
      }
  );
}