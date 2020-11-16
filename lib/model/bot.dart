import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'bot.g.dart';

class Bot {
  final int id;
  final AvatarType avatar;
  final VoiceType voice;

  Bot(this.id, this.avatar, this.voice);

  factory Bot.fromDTO(BotDTO dto) {
    return Bot(
      dto.id,
      AvatarType.from(dto.avatar),
      VoiceType.from(dto.voice),
    );
  }
}

@JsonSerializable()
class BotDTO {
  final int id;
  final String avatar;
  final String voice;

  BotDTO(this.id, this.avatar, this.voice);

  factory BotDTO.fromJson(Map<String, dynamic> json) => _$BotDTOFromJson(json);
  Map<String, dynamic> toJson() => _$BotDTOToJson(this);
}

class AvatarType {
  static final String RABBIT = "RABBIT";
  static final String DOG    = "DOG";
  static final String CAT    = "CAT";
  static final String BEAR   = "BEAR";
  static final String LION   = "LION";
  static final String PANDA  = "PANDA";

  String _value;

  AvatarType.from(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid avatar");
    }
    this._value = v;
  }

  String get() {
    return this._value;
  }

  void set(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid avatar");
    }
    this._value = v;
  }

  bool isEqualTo(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid avatar");
    }
    return this._value == v;
  }

  bool _validate(String v) {
    return v == RABBIT || v == DOG || v == CAT || v == BEAR || v == LION || v == PANDA;
  }

  String toString() {
    if (isEqualTo(RABBIT)) {
      return "토끼";
    }
    if (isEqualTo(DOG)) {
      return "개";
    }
    if (isEqualTo(CAT)) {
      return "고양이";
    }
    if (isEqualTo(BEAR)) {
      return "곰";
    }
    if (isEqualTo(LION)) {
      return "사자";
    }
    if (isEqualTo(PANDA)) {
      return "판다";
    }

    throw Exception("invalid avatar");
  }

  Color toColor() {
    if (isEqualTo(RABBIT)) {
      return Color(0xfffffac2);
    }
    if (isEqualTo(DOG)) {
      return Color(0xffeace9b);
    }
    if (isEqualTo(CAT)) {
      return Color(0xffd8bcbc);
    }
    if (isEqualTo(BEAR)) {
      return Color(0xffcef3f4);
    }
    if (isEqualTo(LION)) {
      return Color(0xffc6ddba);
    }
    if (isEqualTo(PANDA)) {
      return Color(0xff9eb7a5);
    }

    throw Exception("invalid avatar");
  }

  Image toImage() {
    if (isEqualTo(RABBIT)) {
      return Image.asset("assets/rabbit.png");
    }
    if (isEqualTo(DOG)) {
      return Image.asset("assets/dog.png");
    }
    if (isEqualTo(CAT)) {
      return Image.asset("assets/cat.png");
    }
    if (isEqualTo(BEAR)) {
      return Image.asset("assets/bear.png");
    }
    if (isEqualTo(LION)) {
      return Image.asset("assets/lion.png");
    }
    if (isEqualTo(PANDA)) {
      return Image.asset("assets/panda.png");
    }

    throw Exception("invalid avatar");
  }

  Image toCircleImage() {
    if (isEqualTo(RABBIT)) {
      return Image.asset("assets/rabbit_circle.png");
    }
    if (isEqualTo(DOG)) {
      return Image.asset("assets/dog_circle.png");
    }
    if (isEqualTo(CAT)) {
      return Image.asset("assets/cat_circle.png");
    }
    if (isEqualTo(BEAR)) {
      return Image.asset("assets/bear_circle.png");
    }
    if (isEqualTo(LION)) {
      return Image.asset("assets/lion_circle.png");
    }
    if (isEqualTo(PANDA)) {
      return Image.asset("assets/panda_circle.png");
    }

    throw Exception("invalid avatar");
  }
}

class VoiceType {
  static final String MAN1 = "M1";
  static final String MAN2 = "M2";
  static final String WOMAN1 = "W1";
  static final String WOMAN2 = "W2";

  String _value;

  VoiceType.from(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid voice");
    }
    this._value = v;
  }

  String get() {
    return this._value;
  }

  void set(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid voice");
    }
    this._value = v;
  }

  bool isEqualTo(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid voice");
    }
    return this._value == v;
  }

  bool _validate(String v) {
    return v == MAN1 || v == MAN2 || v == WOMAN1 || v == WOMAN2;
  }

  String toString() {
    if (isEqualTo(MAN1)) {
      return "남성1";
    }
    if (isEqualTo(MAN2)) {
      return "남성2";
    }
    if (isEqualTo(WOMAN1)) {
      return "여성1";
    }
    if (isEqualTo(WOMAN2)) {
      return "여성2";
    }

    return "";
  }
}