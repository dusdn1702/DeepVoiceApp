import 'package:deepvoice/model/bot.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  @JsonKey(name: "login_id")
  final String loginID;
  final String nick;
  final String gender;
  final String birth;
  final Push push;
  final Bot bot;
  final int timestamp;

  User(this.id, this.loginID, this.nick, this.gender, this.birth, this.push, this.bot, this.timestamp);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Push {
  final String key;
  final int permission;

  Push(this.key, this.permission);

  factory Push.fromJson(Map<String, dynamic> json) => _$PushFromJson(json);
  Map<String, dynamic> toJson() => _$PushToJson(this);
}

@JsonSerializable()
class LoginResult {
  @JsonKey(name: "session_id")
  final String sessionID;
  final User user;

  LoginResult(this.sessionID, this.user);

  factory LoginResult.fromJson(Map<String, dynamic> json) => _$LoginResultFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}

class Gender {
  final String _MAN    = "M";
  final String _WOMAN  = "W";

  String _value;

  Gender.fromMan() {
    this._value = _MAN;
  }

  Gender.fromWoman() {
    this._value = _WOMAN;
  }

  String get() {
    return this._value;
  }

  void setMan() {
    this._value = _MAN;
  }

  void setWoman() {
    this._value = _WOMAN;
  }

  bool isMan() {
    return this._value == _MAN;
  }

  bool isWoman() {
    return this._value == _WOMAN;
  }

  String toString() {
    if (isMan()) {
      return "남성";
    }
    if (isWoman()) {
      return "여성";
    }

    return "";
  }
}