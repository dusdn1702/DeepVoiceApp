import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voice.g.dart';

class Voice {
  final int id;
  final String name;
  final String text;
  final int size;
  final Uint8List data;
  final DateTime timestamp;

  Voice(this.id, this.name, this.text, this.size, this.data, this.timestamp);

  factory Voice.fromDTO(VoiceDTO dto) {
    return Voice(
      dto.id,
      dto.name,
      dto.text,
      dto.size,
      dto.data != null ? base64Decode(dto.data) : null,
      DateTime.fromMillisecondsSinceEpoch(dto.timestamp * 1000).toLocal(),
    );
  }

  String timestampToString() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
    return formatter.format(this.timestamp);
  }

  String sizeToString() {
    final NumberFormat f = NumberFormat("###,###");
    return f.format(this.size / 1000) + "KB";
  }
}

@JsonSerializable()
class VoiceDTO {
  final int id;
  final String name;
  final String text;
  final int size;
  @JsonKey(nullable: true)
  final String data;
  final int timestamp;

  VoiceDTO(this.id, this.name, this.text, this.size, this.data, this.timestamp);

  factory VoiceDTO.fromJson(Map<String, dynamic> json) => _$VoiceDTOFromJson(json);
  Map<String, dynamic> toJson() => _$VoiceDTOToJson(this);
}