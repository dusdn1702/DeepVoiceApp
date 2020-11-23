import 'package:audioplayers/audioplayers.dart';
import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/share.dart';
import 'package:deepvoice/model/voice.dart';
import 'package:deepvoice/view/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'alert.dart';

class CustomAudioPlayer extends StatefulWidget {
  Voice voice;
  Share share;

  CustomAudioPlayer({this.voice, this.share});

  @override
  _CustomAudioPlayerState createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  bool playing = false;

  AudioPlayer _player;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  @override
  void initState() {
    if (this.widget.voice != null) {
      _findVoice(context, this.widget.voice.id).then((Voice result) {
        _setVoice(result);
      });
    }
    if (this.widget.share != null) {
      this.widget.voice = this.widget.share.voice;
      _findShareVoice(context, this.widget.share.id).then((Voice result) {
        _setVoice(result);
      });
    }
    super.initState();
  }

  void _setVoice(Voice v) {
    setState(() {
      this.widget.voice = v;
      this._player = AudioPlayer();

      this._player.durationHandler = (d) {
        setState(() {
          musicLength = d;
        });
      };
      this._player.positionHandler = (p) {
        setState(() {
          position = p;
        });
      };
      this._player.completionHandler = () {
        setState(() {
          playing = false;
        });
      };
    });
  }

  @override
  void dispose() {
    this._player.pause();
    this._player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width - (28.0 * 2.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                const Radius.circular(7.5),
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: EdgeInsets.only(top: 10),
                    icon: const Icon(Icons.close),
                    onPressed: () => {Navigator.pop(context)},
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(this.widget.voice.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
                ),
                SizedBox(height: 13),
                musicSlider(),
                _playButton(this.widget.voice.id),
                SizedBox(height: 19.5),
              ],
            ),
          )
      ),
    );
  }

  Widget musicSlider() {
    return Container(
      width: double.infinity,
      child: Slider.adaptive(
        activeColor: Color(0xffaf8eff),
        inactiveColor: Color(0xfff0e9ff),
        value: position.inSeconds.toDouble(),
        max: musicLength.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        }
      )
    ) ;
  }

  void seekToSec(int sec) {
    if (this._player == null) {
      return;
    }

    Duration newPos = Duration(seconds: sec);
    this._player.seek(newPos);
  }

  Widget _playButton(int voiceID) {
    return this._player == null ? Container(width: 60, height: 60, child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor, strokeWidth: 6.0)) :
      FlatButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () async{
          if (!playing) {
            this._player.playBytes(this.widget.voice.data);
            setState(() {
              playing = true;
            });
          }
          else {
            this._player.pause();
            setState(() {
              playing = false;
            });
          }
        },
        child:
          _playButtonIcon(),
      );
  }

  Widget _playButtonIcon(){
    if(playing) return Container(
      width: 60,
      height: 60,
      child: Image.asset('assets/popup_pause.png'),
    );
    else return Container(
      width: 60,
      height: 60,
      child: Image.asset('assets/popup_play.png'),
    );
  }
}

void audioPlayer(BuildContext context, {Voice voice, Share share}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAudioPlayer(voice: voice, share: share);
      }
  );
}

Future<Voice> _findVoice(BuildContext context, int voiceID) async {
  try {
    APIClient client = APIClient();
    Voice currentVoice = await client.getVoice(voiceID);
    return currentVoice;
  } catch (e) {
    if (e is APIException) {
      if (e.errorCode == APIStatus.InvalidParameter) {
        alert(context, "올바른 정보를 입력해주세요.", "확인");
        return null;
      } else if (e.errorCode == APIStatus.UnknownSession) {
        alert(context, "세션이 만료됐습니다.", "확인", onTap: () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
        });
        return null;
      } else if (e.errorCode == APIStatus.NotFound) {
        alert(context, "음원 정보가 존재하지 않습니다.", "확인", onTap: () {
          Navigator.of(context).pop();
        });
        return null;
      }
    }
    alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
    print(e);
    return null;
  }
}

Future<Voice> _findShareVoice(BuildContext context, int shareID) async {
  try {
    APIClient client = APIClient();
    Voice voice = await client.getShareVoice(shareID);
    return voice;
  } catch (e) {
    if (e is APIException) {
      if (e.errorCode == APIStatus.InvalidParameter) {
        alert(context, "올바른 정보를 입력해주세요.", "확인");
        return null;
      } else if (e.errorCode == APIStatus.UnknownSession) {
        alert(context, "세션이 만료됐습니다.", "확인", onTap: () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
        });
        return null;
      } else if (e.errorCode == APIStatus.NotFound) {
        alert(context, "음원 정보가 존재하지 않습니다.", "확인", onTap: () {
          Navigator.of(context).pop();
        });
        return null;
      }
    }
    alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
    print(e);
    return null;
  }
}