// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotDTO _$BotDTOFromJson(Map<String, dynamic> json) {
  return BotDTO(
    json['id'] as int,
    json['avatar'] as String,
    json['voice'] as String,
  );
}

Map<String, dynamic> _$BotDTOToJson(BotDTO instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'voice': instance.voice,
    };
