// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoiceDTO _$VoiceDTOFromJson(Map<String, dynamic> json) {
  return VoiceDTO(
    json['id'] as int,
    json['name'] as String,
    json['text'] as String,
    json['size'] as int,
    json['data'] as String,
    json['timestamp'] as int,
  );
}

Map<String, dynamic> _$VoiceDTOToJson(VoiceDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'text': instance.text,
      'size': instance.size,
      'data': instance.data,
      'timestamp': instance.timestamp,
    };
