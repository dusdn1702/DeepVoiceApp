import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

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

  Future<LoginResult> login(String id, String password) async {
    Map<String, dynamic> res = await _call("api/v1/user/login", {
      "login_id": id,
      "login_password": password,
    });

    return LoginResult.fromJson(res);
  }

  Future<void> logout(String sessionID) async {
    await _call("api/v1/user/logout", {
      "session_id": sessionID,
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