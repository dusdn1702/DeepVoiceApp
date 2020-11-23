import 'package:deepvoice/model/bot.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'user.g.dart';

class User {
  final int id;
  final String loginID;
  final String nick;
  final Gender gender;
  final DateTime birth;
  final Push push;
  final Bot bot;
  final DateTime timestamp;

  User(this.id, this.loginID, this.nick, this.gender, this.birth, this.push, this.bot, this.timestamp);

  factory User.fromDTO(UserDTO dto) {
    return User(
      dto.id,
      dto.loginID,
      dto.nick,
      Gender.from(dto.gender),
      DateFormat("yyyy-MM-dd").parse(dto.birth),
      dto.push,
      Bot.fromDTO(dto.bot),
      DateTime.fromMillisecondsSinceEpoch(dto.timestamp * 1000),
    );
  }

  String birthToString() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this.birth);
  }
}

@JsonSerializable()
class UserDTO {
  final int id;
  @JsonKey(name: "login_id")
  final String loginID;
  final String nick;
  final String gender;
  final String birth;
  final Push push;
  final BotDTO bot;
  final int timestamp;

  UserDTO(this.id, this.loginID, this.nick, this.gender, this.birth, this.push, this.bot, this.timestamp);

  factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
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
  final UserDTO user;

  LoginResult(this.sessionID, this.user);

  factory LoginResult.fromJson(Map<String, dynamic> json) => _$LoginResultFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}

class Gender {
  static final String MAN    = "M";
  static final String WOMAN  = "W";

  String _value;

  Gender.from(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid gender");
    }
    this._value = v;
  }

  String get() {
    return this._value;
  }

  void set(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid gender");
    }
    this._value = v;
  }

  bool isEqualTo(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid gender");
    }
    return this._value == v;
  }

  bool _validate(String v) {
    return v == MAN || v == WOMAN;
  }

  String toString() {
    if (isEqualTo(MAN)) {
      return "남성";
    }
    if (isEqualTo(WOMAN)) {
      return "여성";
    }

    throw Exception("invalid gender");
  }
}