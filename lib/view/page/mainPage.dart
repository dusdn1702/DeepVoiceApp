import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/bot.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/preference.dart';
import 'package:deepvoice/view/page/login.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:deepvoice/view/widget/sidebar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Deep Voice'),
      ),
      endDrawer: SideBar(_findUser(context)),
    );
  }

  Future<User> _findUser(BuildContext context) async {
    try {
      APIClient client = APIClient();
      User currentUser = await client.getUser();
      return currentUser;
    } catch (e) {
      if (e is APIException) {
        if (e.errorCode == APIStatus.InvalidParameter) {
          alert(context, "올바른 정보를 입력해주세요.", "확인");
          return null;
        } else if (e.errorCode == APIStatus.UnknownSession) {
          alert(context, "세션이 만료됐습니다.", "확인", onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          });
          return null;
        } else if (e.errorCode == APIStatus.NotFound) {
          alert(context, "사용자 정보가 존재하지 않습니다.", "확인");
          return null;
        }
      }
      alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
      print(e);
      return null;
    }
  }
}