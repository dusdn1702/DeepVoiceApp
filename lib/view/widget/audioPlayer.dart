import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:deepvoice/model/voice.dart';
import 'package:deepvoice/view/page/album.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';

class CustomAudioPlayer extends StatefulWidget {
  final Voice _voice;

  CustomAudioPlayer(this._voice);

  @override
  _CustomAudioPlayerState createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  bool playing = false;

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
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: EdgeInsets.only(top: 18.3),
                    icon: const Icon(Icons.close, size: 10),
                    onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumPage()))
                  },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0),
                  child: Text(this.widget._voice.name),
                ),
                SizedBox(height: 13),
                musicSlider(),
                Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 4.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 23.8,
                          child: Text(
                            "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                            style: TextStyle(
                              fontSize: 11,
                            ),),),
                        Container(
                          width: 248,
                        ),
                        Container(
                          width: 23.8,
                          child: Text(
                            "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                //여기에 오디오 플레이어
                SizedBox(height: 19.3),
                _playButton(this.widget._voice.id),
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
    cache = AudioCache(fixedPlayer: _player, prefix: 'assets/audio/');

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
      FlatButton(
        onPressed: () async{
          if (!playing) {
            print(this.widget._voice.data.length);
            this.cache.playBytes(this.widget._voice.data);
            setState(() {
              playing = true;
            });
          }
          else {
            _player.pause();
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
      color: Colors.white,
      width: 35.8,
      height: 35.8,
      child: Image.asset('assets/popup_pause.png'),
    );
    else return Container(
      color: Colors.white,
      width: 35.8,
      height: 35.8,
      child: Image.asset('assets/popup_play.png'),
    );
  }
}

void audioPlayer(BuildContext context, Voice voice) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAudioPlayer(voice);
      }
  );
}