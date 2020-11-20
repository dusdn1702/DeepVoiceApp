// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareDTO _$ShareDTOFromJson(Map<String, dynamic> json) {
  return ShareDTO(
    json['id'] as int,
    json['friend_login_id'] as String,
    json['voice'] == null
        ? null
        : VoiceDTO.fromJson(json['voice'] as Map<String, dynamic>),
    json['timestamp'] as int,
  );
}

Map<String, dynamic> _$ShareDTOToJson(ShareDTO instance) => <String, dynamic>{
      'id': instance.id,
      'friend_login_id': instance.friendLoginID,
      'voice': instance.voice,
      'timestamp': instance.timestamp,
    };
