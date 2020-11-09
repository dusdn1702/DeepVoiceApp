import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'bot.g.dart';

@JsonSerializable()
class Bot {
  final int id;
  final String avatar;
  final String voice;

  Bot(this.id, this.avatar, this.voice);

  factory Bot.fromJson(Map<String, dynamic> json) => _$BotFromJson(json);
  Map<String, dynamic> toJson() => _$BotToJson(this);
}

class AvatarType {
  final String _RABBIT = "RABBIT";
  final String _DOG    = "DOG";
  final String _CAT    = "CAT";
  final String _BEAR   = "BEAR";
  final String _LION   = "LION";
  final String _PANDA  = "PANDA";

  String _value;

  AvatarType.fromRabbit() {
    this._value = _RABBIT;
  }

  AvatarType.fromDog() {
    this._value = _DOG;
  }

  AvatarType.fromCat() {
    this._value = _CAT;
  }

  AvatarType.fromBear() {
    this._value = _BEAR;
  }

  AvatarType.fromLion() {
    this._value = _LION;
  }

  AvatarType.fromPanda() {
    this._value = _PANDA;
  }

  String get() {
    return this._value;
  }

  void setRabbit() {
    this._value = _RABBIT;
  }

  void setDog() {
    this._value = _DOG;
  }

  void setCat() {
    this._value = _CAT;
  }

  void setBear() {
    this._value = _BEAR;
  }

  void setLion() {
    this._value = _LION;
  }

  void setPanda() {
    this._value = _PANDA;
  }

  bool isRabbit() {
    return this._value == _RABBIT;
  }

  bool isDog() {
    return this._value == _DOG;
  }

  bool isCat() {
    return this._value == _CAT;
  }

  bool isBear() {
    return this._value == _BEAR;
  }

  bool isLion() {
    return this._value == _LION;
  }

  bool isPanda() {
    return this._value == _PANDA;
  }

  String toString() {
    if (isRabbit()) {
      return "토끼";
    }
    if (isDog()) {
      return "개";
    }
    if (isCat()) {
      return "고양이";
    }
    if (isBear()) {
      return "곰";
    }
    if (isLion()) {
      return "사자";
    }
    if (isPanda()) {
      return "판다";
    }

    return "";
  }

  Color toColor() {
    if (isRabbit()) {
      return Color(0xfffffac2);
    }
    if (isDog()) {
      return Color(0xffeace9b);
    }
    if (isCat()) {
      return Color(0xffd8bcbc);
    }
    if (isBear()) {
      return Color(0xffcef3f4);
    }
    if (isLion()) {
      return Color(0xffc6ddba);
    }
    if (isPanda()) {
      return Color(0xff9eb7a5);
    }

    return Colors.black;
  }

  Image toImage() {
    if (isRabbit()) {
      return Image.asset("assets/rabbit.png");
    }
    if (isDog()) {
      return Image.asset("assets/dog.png");
    }
    if (isCat()) {
      return Image.asset("assets/cat.png");
    }
    if (isBear()) {
      return Image.asset("assets/bear.png");
    }
    if (isLion()) {
      return Image.asset("assets/lion.png");
    }
    if (isPanda()) {
      return Image.asset("assets/panda.png");
    }

    return Image.asset("");
  }

  Image toCircleImage() {
    if (isRabbit()) {
      return Image.asset("assets/rabbit_circle.png");
    }
    if (isDog()) {
      return Image.asset("assets/dog_circle.png");
    }
    if (isCat()) {
      return Image.asset("assets/cat_circle.png");
    }
    if (isBear()) {
      return Image.asset("assets/bear_circle.png");
    }
    if (isLion()) {
      return Image.asset("assets/lion_circle.png");
    }
    if (isPanda()) {
      return Image.asset("assets/panda_circle.png");
    }

    return Image.asset("");
  }
}

class VoiceType {
  final String _MAN1 = "M1";
  final String _MAN2 = "M2";
  final String _WOMAN1 = "W1";
  final String _WOMAN2 = "W2";

  String _value;

  VoiceType(this._value);

  VoiceType.fromMan1() {
    this._value = _MAN1;
  }

  VoiceType.fromMan2() {
    this._value = _MAN2;
  }

  VoiceType.fromWoman1() {
    this._value = _WOMAN1;
  }

  VoiceType.fromWoman2() {
    this._value = _WOMAN2;
  }

  String get() {
    return this._value;
  }

  void setMan1() {
    this._value = _MAN1;
  }

  void setMan2() {
    this._value = _MAN2;
  }

  void setWoman1() {
    this._value = _WOMAN1;
  }

  void setWoman2() {
    this._value = _WOMAN2;
  }

  bool isMan1() {
    return this._value == _MAN1;
  }

  bool isMan2() {
    return this._value == _MAN2;
  }

  bool isWoman1() {
    return this._value == _WOMAN1;
  }

  bool isWoman2() {
    return this._value == _WOMAN2;
  }

  String toString() {
    if (isMan1()) {
      return "남성1";
    }
    if (isMan2()) {
      return "남성2";
    }
    if (isWoman1()) {
      return "여성1";
    }
    if (isWoman2()) {
      return "여성2";
    }

    return "";
  }
}