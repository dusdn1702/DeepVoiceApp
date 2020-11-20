import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:deepvoice/model/voice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAudioPlayer extends StatefulWidget {
  final Voice _voice;

  CustomAudioPlayer(this._voice);

  @override
  _CustomAudioPlayerState createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  bool playing = false;

  AudioPlayer _player;

  Duration position = new Duration();
  Duration musicLength = new Duration();

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
                  child: Text(this.widget._voice.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
                ),
                SizedBox(height: 13),
                musicSlider(),
                _playButton(this.widget._voice.id),
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
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

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
    _player.completionHandler = () {
      setState(() {
        playing = false;
      });
    };
  }

  Widget _playButton(int voiceID) {
    return
      FlatButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () async{
          if (!playing) {
            this._player.playBytes(this.widget._voice.data);
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

void audioPlayer(BuildContext context, Voice voice) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAudioPlayer(voice);
      }
  );
}