import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';
import 'package:json_serializable/type_helper.dart';

class CustomAudioPlayer extends StatefulWidget {
  final String voiceTitle;

  CustomAudioPlayer(this.voiceTitle);

  @override
  _CustomAudioPlayerState createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  bool playing = false;
  String voiceTitle;

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                IconButton(
                  icon: const Icon(Icons.close, size: 10),
                  onPressed: () => {Navigator.pop(context)},
                  padding: EdgeInsets.only(
                      left: 197, top: 19, right: 15, bottom: 8),
                ),
                Container(padding: EdgeInsets.only(left: 0),
                  child: Text(this.voiceTitle),),
                SizedBox(height: 13),
                musicSlider(),
                Container(
                    width: 182.5,
                    padding: EdgeInsets.only(top: 4.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${position.inMinutes}:${position.inSeconds.remainder(
                              60)}",
                          style: TextStyle(
                            fontSize: 5.3,
                          ),),
                        Container(
                          padding: EdgeInsets.only(left: 137),
                          child: Text(
                            "${position.inMinutes}:${position.inSeconds
                                .remainder(60)}",
                            style: TextStyle(
                              fontSize: 5.3,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                //여기에 오디오 플레이어
                SizedBox(height: 19.3),
                //_playButton(1),
                SizedBox(height: 19.5),
              ],
            ),
          )
      ),
    );
  }

  Widget musicSlider() {
    return Slider.adaptive(
        activeColor: Color(0xffaf8eff),
        inactiveColor: Color(0xfff0e9ff),
        value: position.inSeconds.toDouble(),
        max: musicLength.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        });
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };
    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  Widget _playButton(int voiceID) {
    return
      RaisedButton(
        onPressed: () {
          if (!playing) {
            cache.play('assets/$voiceID.mp3');
            setState(() {
              playing = true;
              child:
              Image.asset('assets/popup_pause.png');
            });
          }
          else {
            setState(() {
              playing = false;
              child:
              Image.asset('assets/popup_play.png');
            });
          }
          //여기에 버튼 바꾸기
        },
      );
  }

//  void playVoice(int voiceID){
//    final AudioCache player = AudioCache();
//    player.play('assets/$voiceID.mp3');
//  }
}

void audioPlayer(BuildContext context, String voiceTitle) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAudioPlayer(voiceTitle);
      }
  );
}