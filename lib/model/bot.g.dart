// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bot _$BotFromJson(Map<String, dynamic> json) {
  return Bot(
    json['id'] as int,
    json['avatar'] as String,
    json['voice'] as String,
  );
}

Map<String, dynamic> _$BotToJson(Bot instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'voice': instance.voice,
    };
