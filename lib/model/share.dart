import 'package:deepvoice/model/voice.dart';

import 'package:json_annotation/json_annotation.dart';

part 'share.g.dart';

class Share {
  final int id;
  final String friendLoginID;
  final Voice voice;
  final DateTime timestamp;

  Share(this.id, this.friendLoginID, this.voice, this.timestamp);

  factory Share.fromDTO(ShareDTO dto) {
    return Share(
      dto.id,
      dto.friendLoginID,
      Voice.fromDTO(dto.voice),
      DateTime.fromMillisecondsSinceEpoch(dto.timestamp * 1000),
    );
  }
}

@JsonSerializable()
class ShareDTO {
  final int id;
  @JsonKey(name: "friend_login_id")
  final String friendLoginID;
  final VoiceDTO voice;
  final int timestamp;

  ShareDTO(this.id, this.friendLoginID, this.voice, this.timestamp);

  factory ShareDTO.fromJson(Map<String, dynamic> json) => _$ShareDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ShareDTOToJson(this);
}