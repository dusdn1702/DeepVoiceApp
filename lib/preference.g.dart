// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preference _$PreferenceFromJson(Map<String, dynamic> json) {
  return Preference(
    json['session_id'] as String,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'session_id': instance.sessionID,
      'user': instance.user,
    };
