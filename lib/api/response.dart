import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class APIResponse {
  final int status;
  @JsonKey(nullable: true)
  final String message;
  @JsonKey(nullable: true)
  final dynamic data;

  APIResponse(this.status, this.message, this.data);

  static APIResponse fromJson(Map<String, dynamic> json) => _$APIResponseFromJson(json);
  Map<String, dynamic> toJson() => _$APIResponseToJson(this);
}

class APIStatus {
  static const Okay = 200;

  static const InvalidParameter    = 400;
  static const IncorrectCredential = 401;
  static const UnknownSession      = 402;
  static const Duplicated          = 403;
  static const NotFound            = 404;

  
  static const InternalServerError = 500;
}