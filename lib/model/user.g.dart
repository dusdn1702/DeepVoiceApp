// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) {
  return UserDTO(
    json['id'] as int,
    json['login_id'] as String,
    json['nick'] as String,
    json['gender'] as String,
    json['birth'] as String,
    json['push'] == null
        ? null
        : Push.fromJson(json['push'] as Map<String, dynamic>),
    json['bot'] == null
        ? null
        : BotDTO.fromJson(json['bot'] as Map<String, dynamic>),
    json['timestamp'] as int,
  );
}

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'id': instance.id,
      'login_id': instance.loginID,
      'nick': instance.nick,
      'gender': instance.gender,
      'birth': instance.birth,
      'push': instance.push,
      'bot': instance.bot,
      'timestamp': instance.timestamp,
    };

Push _$PushFromJson(Map<String, dynamic> json) {
  return Push(
    json['key'] as String,
    json['permission'] as int,
  );
}

Map<String, dynamic> _$PushToJson(Push instance) => <String, dynamic>{
      'key': instance.key,
      'permission': instance.permission,
    };

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) {
  return LoginResult(
    json['session_id'] as String,
    json['user'] == null
        ? null
        : UserDTO.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'session_id': instance.sessionID,
      'user': instance.user,
    };
