import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicMyBotSettingPage extends StatefulWidget {
  final Function onComplete;

  BasicMyBotSettingPage(this.onComplete);

  @override
  _BasicMyBotSettingPageState createState() => _BasicMyBotSettingPageState();
}

class _BasicMyBotSettingPageState extends State<BasicMyBotSettingPage> {
  String voice = "M1";
  String avatar = "RABBIT";

  @override
  Widget build(BuildContext context) {
    var avatarSection1 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            _btnAvatar(
              Image.asset('assets/rabbit.png'),
              Color(0XFFFFFAC2),
              avatar == "RABBIT" ? Color(0XFF6666CC) : Colors.black,
              avatar == "RABBIT" ? 4.5 : 0.0,
              () {
                setState(() {
                  avatar = "RABBIT";
                });
              }
            ),
            Text(
              '토끼',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        Column(
          children: <Widget>[
            _btnAvatar(
                Image.asset('assets/dog.png'),
                Color(0Xffeace9b),
                avatar == "DOG" ? Color(0XFF6666CC) : Colors.black,
                avatar == "DOG" ? 4.5 : 0.0,
                () {
                  setState(() {
                    avatar = "DOG";
                  });
                }
            ),
            Text('개', style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        Column(
          children: <Widget>[
            _btnAvatar(
                Image.asset('assets/cat.png'),
                Color(0Xffd8bcbc),
                avatar == "CAT" ? Color(0XFF6666CC) : Colors.black,
                avatar == "CAT" ? 4.5 : 0.0,
                () {
                  setState(() {
                    avatar = "CAT";
                  });
                }
            ),
            Text('고양이', style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
      ],
    );
    var avatarSection2 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            _btnAvatar(
                Image.asset('assets/bear.png'),
                Color(0Xffcef3f4),
                avatar == "BEAR" ? Color(0XFF6666CC) : Colors.black,
                avatar == "BEAR" ? 4.5 : 0.0,
                () {
                  setState(() {
                    avatar = "BEAR";
                  });
                }
            ),
            Text('곰', style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        Column(
          children: <Widget>[
            _btnAvatar(
                Image.asset('assets/lion.png'),
                Color(0Xffc6ddba),
                avatar == "LION" ? Color(0XFF6666CC) : Colors.black,
                avatar == "LION" ? 4.5 : 0.0,
                () {
                  setState(() {
                    avatar = "LION";
                  });
                }
            ),
            Text('사자', style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        Column(
          children: <Widget>[
            _btnAvatar(
                Image.asset('assets/panda.png'),
                Color(0Xff9eb7a5),
                avatar == "PANDA" ? Color(0XFF6666CC) : Colors.black,
                avatar == "PANDA" ? 4.5 : 0.0,
                () {
                  setState(() {
                    avatar = "PANDA";
                  });
                }
            ),
            Text('판다', style: TextStyle(fontWeight: FontWeight.bold))
          ],
        )
      ],
    );
    var voiceTypeSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            ButtonTheme(
              minWidth: 150,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.deepPurpleAccent)),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    voice = "M1";
                  });
                },
                child: Text(
                  '남성1',
                  style: TextStyle(
                      fontSize: 18,
                      color: voice == "M1"
                          ? Color(0XFFFFFFFF)
                          : Color(0XFF7165E3)),
                ),
                color: voice == "M1" ? Color(0XFF7165E3) : Color(0XFFFFFFFF),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            ButtonTheme(
              minWidth: 150,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.deepPurpleAccent)),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    voice = "M2";
                  });
                },
                child: Text(
                  '남성2',
                  style: TextStyle(
                      fontSize: 18,
                      color: voice == "M2"
                          ? Color(0XFFFFFFFF)
                          : Color(0XFF7165E3)),
                ),
                color: voice == "M2" ? Color(0XFF7165E3) : Color(0XFFFFFFFF),
              ),
              padding: (EdgeInsets.all(10)),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            ButtonTheme(
              minWidth: 150,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.deepPurpleAccent)),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    voice = "W1";
                  });
                },
                child: Text(
                  '여성1',
                  style: TextStyle(
                      fontSize: 18,
                      color: voice == "W1"
                          ? Color(0XFFFFFFFF)
                          : Color(0XFF7165E3)),
                ),
                color: voice == "W1" ? Color(0XFF7165E3) : Color(0XFFFFFFFF),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            ButtonTheme(
              minWidth: 150,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.deepPurpleAccent)),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    voice = "W2";
                  });
                },
                child: Text(
                  '여성2',
                  style: TextStyle(
                      fontSize: 18,
                      color: voice == "W2"
                          ? Color(0XFFFFFFFF)
                          : Color(0XFF7165E3)),
                ),
                color: voice == "W2" ? Color(0XFF7165E3) : Color(0XFFFFFFFF),
              ),
            ),
          ],
        ),
      ],
    );
    var buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ButtonTheme(
          minWidth: 330,
          height: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: RaisedButton(
            onPressed: () {
              this.widget.onComplete(avatar, voice);
              Navigator.pop(context);
            },
            child: Text(
              '설정 완료',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            color: Color(0xFF7165e3),
          ),
        ),
      ],
    );
    return MaterialApp(
        title: 'Deep Voice',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF8b80f9),
            title: Text(
              '기본 마이봇 설정',
              style: TextStyle(fontSize: 18),
            ),
            leading: new IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)},
              iconSize: 28.0,
              color: const Color(0xFFFFFFFF),
            ),
            centerTitle: true,
          ),
          body: ListView(children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 10),
                child: Text(
                  '아바타 설정',
                  style: TextStyle(fontSize: 18, color: Color(0xFF6666cc)),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 15),
                child: Text(
                  '아바타는 추후 마이 페이지에서 수정 가능합니다.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                )),
            avatarSection1,
            Padding(padding: EdgeInsets.all(5)),
            avatarSection2,
            Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 10),
                child: Text(
                  '목소리 설정',
                  style: TextStyle(fontSize: 18, color: Color(0XFF7165E3)),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 15),
                child: Text(
                  '한번 선택한 목소리는 수정 불가능합니다.\n'
                  '자신의 목소리와 가장 유사한 목소리를 선택해 주세요.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                )),
            voiceTypeSection,
            Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 10),
                child: Text(
                  '소리가 들리지 않는 경우 미디어 볼륨을 키워 보세요.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                )),
            Padding(padding: EdgeInsets.all(15)),
            buttonSection,
            Padding(padding: EdgeInsets.all(15))
          ]),
        ));
  }

  Widget _btnAvatar(Widget child, Color bgColor, Color borderColor, double borderWidth, Function onTap) {
    return ClipOval(
      child: Container(
        width: MediaQuery.of(context).size.width / 3.0 - (12.0 * 4),
        height: MediaQuery.of(context).size.width / 3.0 - (12.0 * 4),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWidth),
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              child: child,
              onTap: onTap,
          ),
        ),
      ),
    );
  }
}