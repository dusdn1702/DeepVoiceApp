import 'dart:convert';

import 'package:deepvoice/model/user.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preference.g.dart';

final String _PREFERENCE_NAME = "DEEPVOICE_PREFERENCE";

@JsonSerializable()
class Preference {
  @JsonKey(name: "session_id")
  String sessionID;
  User user;

  Preference(this.sessionID, this.user);

  Future<void> save() async {
    SharedPreferences v = await SharedPreferences.getInstance();
    v.setString(_PREFERENCE_NAME, json.encode(this));
  }

  bool isLogin() {
    return sessionID.isNotEmpty && user != null;
  }

  factory Preference.fromJson(Map<String, dynamic> json) => _$PreferenceFromJson(json);
  Map<String, dynamic> toJson() => _$PreferenceToJson(this);
}

Future<Preference> loadPreference() async {
  SharedPreferences p = await SharedPreferences.getInstance();
  String v = p.getString(_PREFERENCE_NAME);
  if (v == null || v.isEmpty) {
    return null;
  }

  return Preference.fromJson(json.decode(v));
}