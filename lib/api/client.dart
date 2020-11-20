import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:deepvoice/model/progress.dart';
import 'package:deepvoice/model/share.dart';
import 'package:flutter/foundation.dart';

import 'package:deepvoice/model/voice.dart';
import 'package:deepvoice/model/bot.dart';
import 'package:deepvoice/preference.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/user.dart';

import 'package:http/http.dart';

class APIClient {
  static const Duration _API_TIMEOUT_DURATION = const Duration(seconds: 30);

  static APIClient _singleton;

  final Client _client = Client();
  final String _url;

  factory APIClient({String url}) {
    _singleton = APIClient._internal(
      url == null  ? _singleton._url : url,
    );

    return _singleton;
  }

  APIClient._internal(String url)
      : this._url = url {
    if (_client == null) {
      throw Exception("HTTP client: unsupported platform.");
    }
  }

  Future<void> login(String id, String password) async {
    Map<String, dynamic> res = await _call("api/v1/user/login", {
      "login_id": id,
      "login_password": password,
    });
    LoginResult v = LoginResult.fromJson(res);
    await Preference(v.sessionID).save();
  }

  Future<void> logout() async {
    String id =  await _getSessionID();
    await _call("api/v1/user/logout", {
      "session_id": id,
    });
  }

  Future<void> signUp(String loginID, String loginPW, String nick, String gender, String birth, String avatar, String voice) async {
    await _call("api/v1/user/add", {
      "login_id": loginID,
      "login_password": loginPW,
      "nick": nick,
      "gender": gender,
      "birth": birth,
      "avatar": avatar,
      "voice": voice,
    });
  }

  Future<User> getUser() async {
    String id =  await _getSessionID();
    Map<String, dynamic> res = await _call("api/v1/user/get", {
      "session_id": id,
    });
    UserDTO dto = UserDTO.fromJson(res);

    return User.fromDTO(dto);
  }

  Future<void> updateUserNick(String nick) async {
    String id =  await _getSessionID();
    await _call("api/v1/user/update/nick", {
      "session_id": id,
      "nick": nick,
    });
  }

  Future<void> updateUserAvatar(AvatarType avatar) async {
    String id =  await _getSessionID();
    await _call("api/v1/user/update/avatar", {
      "session_id": id,
      "avatar": avatar.get(),
    });
  }

  Future<void> updateUserPassword(String oldPassword, String newPassword) async {
    String id =  await _getSessionID();
    await _call("api/v1/user/update/password", {
      "session_id": id,
      "old_password": oldPassword,
      "new_password": newPassword,
    });
  }

  Future<void> updateUserPushKey(String pushKey) async {
    String id =  await _getSessionID();
    await _call("api/v1/user/update/push", {
      "session_id": id,
      "push_key": pushKey,
    });
  }

  Future<Voice> getVoice(int voiceID) async {
    String id =  await _getSessionID();
    Map<String, dynamic> res = await _call("api/v1/voice/get", {
      "session_id": id,
      "voice_id": voiceID,
    });
    VoiceDTO dto = VoiceDTO.fromJson(res);

    return Voice.fromDTO(dto);
  }

  Future<List<Voice>> getVoiceList({String name}) async {
    String id =  await _getSessionID();
    List<dynamic> res = await _call("api/v1/voice/list", {
      "session_id": id,
      "name": name != null ? name : "",
    });

    return res.map((dynamic v) {
      VoiceDTO dto = VoiceDTO.fromJson(v);
      return Voice.fromDTO(dto);
    }).toList();
  }

  Future<void> addVoice(String text) async {
    String id =  await _getSessionID();
    await _call("api/v1/voice/add", {
      "session_id": id,
      "text": text,
    });
  }

  Future<void> updateVoiceName(int voiceID, String name) async {
    String id =  await _getSessionID();
    await _call("api/v1/voice/update/name", {
      "session_id": id,
      "voice_id": voiceID,
      "name": name,
    });
  }

  Future<List<User>> getFriendList(ProgressStatus status, {String loginID}) async {
    String id =  await _getSessionID();
    List<dynamic> res = await _call("api/v1/friend/list", {
      "session_id": id,
      "status": status.get(),
      "friend_login_id": loginID != null ? loginID : "",
    });

    return res.map((dynamic v) {
      UserDTO dto = UserDTO.fromJson(v);
      return User.fromDTO(dto);
    }).toList();
  }

  Future<void> addFriend(String loginID) async {
    String id =  await _getSessionID();
    await _call("api/v1/friend/add", {
      "session_id": id,
      "receiver_login_id": loginID,
    });
  }

  Future<void> acceptFriend(int userID) async {
    String id =  await _getSessionID();
    await _call("api/v1/friend/accept", {
      "session_id": id,
      "friend_user_id": userID,
    });
  }

  Future<void> deleteFriend(int userID) async {
    String id =  await _getSessionID();
    await _call("api/v1/friend/delete", {
      "session_id": id,
      "friend_user_id": userID,
    });
  }

  Future<List<Share>> getShareList(ProgressStatus status) async {
    String id =  await _getSessionID();
    List<dynamic> res = await _call("api/v1/share/list", {
      "session_id": id,
      "status": status.get(),
    });

    return res.map((dynamic v) {
      ShareDTO dto = ShareDTO.fromJson(v);
      return Share.fromDTO(dto);
    }).toList();
  }

  Future<void> addShare(int voiceID, int userID) async {
    String id =  await _getSessionID();
    await _call("api/v1/share/add", {
      "session_id": id,
      "voice_id": voiceID,
      "friend_user_id": userID,
    });
  }

  Future<void> acceptShare(int shareID) async {
    String id =  await _getSessionID();
    await _call("api/v1/share/accept", {
      "session_id": id,
      "share_id": shareID,
    });
  }

  Future<void> denyShare(int shareID) async {
    String id =  await _getSessionID();
    await _call("api/v1/share/deny", {
      "session_id": id,
      "share_id": shareID,
    });
  }

  Future<void> deleteShare(int shareID) async {
    String id =  await _getSessionID();
    await _call("api/v1/share/delete", {
      "session_id": id,
      "share_id": shareID,
    });
  }

  Future<String> _getSessionID() async {
    Preference p =  await loadPreference();
    if (p == null || p.sessionID.isEmpty) {
      throw APIException(
        errorCode: APIStatus.UnknownSession,
        errorMessage: "세션정보가 존재하지 않습니다.",
      );
    }

    return p.sessionID;
  }

  Future<dynamic> _call(String method, Map<String, dynamic> params) async {
    try {
      Response response = await _client.post(
        _url + "/" + method,
        body: json.encode(params),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        _API_TIMEOUT_DURATION,
        onTimeout: () {
          throw TimeoutException("connection timeout exceeded");
        },
      );

      if (response.statusCode != 200) {
        throw APIException(
          httpStatus: response.statusCode,
          errorMessage: "unexpected HTTP status code: ${response.statusCode}",
        );
      }

      String httpBody = utf8.decode(response.bodyBytes);
      APIResponse res = APIResponse.fromJson(json.decode(httpBody));
      if (res.status != APIStatus.Okay) {
        throw APIException(
          httpStatus: response.statusCode,
          errorCode: res.status,
          errorMessage: res.message,
        );
      }

      return res.data;
    } catch (e) {
      if (e is SocketException) {
        print("client socket exception: address=${e.address}, port=${e.port}, message=${e.message}");
      } else if (e is APIException) {
        print("client api exception: errorCode=${e.errorCode}, message=${e.errorMessage}, httpStatus=${e.httpStatus}");
        switch (e.errorCode) {
          case APIStatus.InvalidParameter:
            FlutterError.reportError(FlutterErrorDetails(exception: e));
            break;
          default:
            break;
        }
        rethrow;
      } else {
        print("client exception: $e");
      }
    }
  }
}