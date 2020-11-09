import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';
import 'package:deepvoice/model/bot.dart';

class SettingBotPage extends StatefulWidget {
  final AvatarType avatar;
  final VoiceType voice;
  final Function onComplete;

  SettingBotPage(this.avatar, this.voice, this.onComplete);

  @override
  _SettingBotPageState createState() => _SettingBotPageState();
}

class _SettingBotPageState extends State<SettingBotPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            SizedBox(height: 23.0),
            _settingAvatar(),
            SizedBox(height: 35.0),
            _settingVoice(),
            SizedBox(height: 35.0),
            CustomButton("설정 완료", CustomButtonType.Default, () {
              this.widget.onComplete(this.widget.avatar, this.widget.voice);
              Navigator.pop(context);
            }),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("기본 마이봇 설정"),
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () => {Navigator.pop(context)},
        iconSize: 28.0,
        color: Colors.white,
      ),
      centerTitle: true,
    );
  }

  Widget _settingAvatar() {
    return Container(
      child: Column(
        children: [
          _settingAvatarHeader(),
          SizedBox(height: 21.0),
          _settingAvatarBody(),
        ],
      ),
    );
  }

  Widget _settingAvatarHeader() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("아바타 설정", style: TextStyle(color: Theme.of(context).primaryColor)),
          SizedBox(height: 12.0),
          Row(children: [
            Text("아바타는 추후 마이페이지에서 ", style: TextStyle(color: Color(0xff666666), fontSize: 13)),
            Text("가능", style: TextStyle(color: Theme.of(context).accentColor, fontSize: 13)),
            Text("합니다.", style: TextStyle(color: Color(0xff666666), fontSize: 13)),
          ]),
        ],
      ),
    );
  }

  Widget _settingAvatarBody() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _btnRabbit()),
              SizedBox(width: 11.0),
              Expanded(child: _btnDog()),
              SizedBox(width: 11.0),
              Expanded(child: _btnCat()),
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(child: _btnBear()),
              SizedBox(width: 11.0),
              Expanded(child: _btnLion()),
              SizedBox(width: 11.0),
              Expanded(child: _btnPanda()),
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
          _btnAvatar(AvatarType.fromRabbit().toCircleImage(), this.widget.avatar.isRabbit(), () {
            setState(() {
              this.widget.avatar.setRabbit();
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.fromRabbit().toString()),
        ],
      ),
    );
  }

  Widget _btnDog() {
    return Container(
      child: Column(
        children: [
          _btnAvatar(AvatarType.fromDog().toCircleImage(), this.widget.avatar.isDog(), () {
            setState(() {
              this.widget.avatar.setDog();
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.fromDog().toString()),
        ],
      ),
    );
  }

  Widget _btnCat() {
    return Container(
      child: Column(
        children: [
          _btnAvatar(AvatarType.fromCat().toCircleImage(), this.widget.avatar.isCat(), () {
            setState(() {
              this.widget.avatar.setCat();
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.fromCat().toString()),
        ],
      ),
    );
  }

  Widget _btnBear() {
    return Container(
      child: Column(
        children: [
          _btnAvatar(AvatarType.fromBear().toCircleImage(), this.widget.avatar.isBear(), () {
            setState(() {
              this.widget.avatar.setBear();
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.fromBear().toString()),
        ],
      ),
    );
  }

  Widget _btnLion() {
    return Container(
      child: Column(
        children: [
          _btnAvatar(AvatarType.fromLion().toCircleImage(), this.widget.avatar.isLion(), () {
            setState(() {
              this.widget.avatar.setLion();
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.fromLion().toString()),
        ],
      ),
    );
  }

  Widget _btnPanda() {
    return Container(
      child: Column(
        children: [
          _btnAvatar(AvatarType.fromPanda().toCircleImage(), this.widget.avatar.isPanda(), () {
            setState(() {
              this.widget.avatar.setPanda();
            });
          }),
          SizedBox(height: 8.0),
          Text(AvatarType.fromPanda().toString()),
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

  Widget _settingVoice() {
    return Container(
      child: Column(
        children: [
          _settingVoiceHeader(),
          SizedBox(height: 21.0),
          _settingVoiceBody(),
        ],
      ),
    );
  }

  Widget _settingVoiceHeader() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("목소리 설정", style: TextStyle(color: Theme.of(context).primaryColor)),
          SizedBox(height: 12.0),
          Row(children: [
            Text("한번 선택한 목소리는 수정 ", style: TextStyle(color: Color(0xff666666), fontSize: 13)),
            Text("불가능", style: TextStyle(color: Theme.of(context).errorColor, fontSize: 13)),
            Text("합니다.", style: TextStyle(color: Color(0xff666666), fontSize: 13)),
          ]),
        ],
      ),
    );
  }

  Widget _settingVoiceBody() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _btnMan1()),
              SizedBox(width: 11.0),
              Expanded(child: _btnMan2()),
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(child: _btnWoman1()),
              SizedBox(width: 11.0),
              Expanded(child: _btnWoman2()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _btnMan1() {
    String text = VoiceType.fromMan1().toString();
    Function onTap = () {
      setState(() {
        this.widget.voice.setMan1();
      });
    };
    if (this.widget.voice.isMan1()) {
      return CustomButton(text, CustomButtonType.Default, onTap);
    } else {
      return CustomButton(text, CustomButtonType.Border, onTap);
    }
  }

  Widget _btnMan2() {
    String text = VoiceType.fromMan2().toString();
    Function onTap = () {
      setState(() {
        this.widget.voice.setMan2();
      });
    };
    if (this.widget.voice.isMan2()) {
      return CustomButton(text, CustomButtonType.Default, onTap);
    } else {
      return CustomButton(text, CustomButtonType.Border, onTap);
    }
  }

  Widget _btnWoman1() {
    String text = VoiceType.fromWoman1().toString();
    Function onTap = () {
      setState(() {
        this.widget.voice.setWoman1();
      });
    };
    if (this.widget.voice.isWoman1()) {
      return CustomButton(text, CustomButtonType.Default, onTap);
    } else {
      return CustomButton(text, CustomButtonType.Border, onTap);
    }
  }

  Widget _btnWoman2() {
    String text = VoiceType.fromWoman2().toString();
    Function onTap = () {
      setState(() {
        this.widget.voice.setWoman2();
      });
    };
    if (this.widget.voice.isWoman2()) {
      return CustomButton(text, CustomButtonType.Default, onTap);
    } else {
      return CustomButton(text, CustomButtonType.Border, onTap);
    }
  }
}