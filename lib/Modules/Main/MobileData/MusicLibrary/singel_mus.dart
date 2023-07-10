import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicApp extends StatefulWidget {
  const MusicApp({Key? key, required this.songModel, required this.audioPlayer})
      : super(key: key);

  final SongModel songModel;
  final AudioPlayer audioPlayer;

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  Duration _duration = const Duration();

  Duration _position = const Duration();

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    playSong();
  }

  void playSong() {
    try {
      widget.audioPlayer
          .setAudioSource(AudioSource.uri(Uri.parse(widget.songModel.uri!)));
      widget.audioPlayer.play();
      widget.audioPlayer.setLoopMode(LoopMode.one);
      _isPlaying = true;
    } on Exception {
      log("Can't Parse Song");
    }
    widget.audioPlayer.durationStream.listen((d) {
      if (mounted) {
        setState(() {
          _duration = d!;
        });
      }
    });

    widget.audioPlayer.positionStream.listen((p) {
      if (mounted) {
        setState(() {
          _position = p;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.audioPlayer.stop();
  }

  void stop() async {
    await widget.audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 24, 37),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Now Playing',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60.0,
                    child: Icon(
                      Icons.music_note,
                      size: 80.0,
                      color: Color.fromARGB(255, 35, 24, 37),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    widget.songModel.displayNameWOExt,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    widget.songModel.artist.toString() == "<unknown>"
                        ? "UnKnown Artist"
                        : widget.songModel.artist.toString(),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        _position.toString().split(".")[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: const SliderThemeData(
                            thumbColor: Colors.white,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 6.0),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 14.0),
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Colors.white38,
                          ),
                          child: Slider(
                            min: const Duration(microseconds: 0)
                                .inSeconds
                                .toDouble(),
                            value: _position.inSeconds.toDouble(),
                            max: _duration.inSeconds.toDouble(),
                            onChanged: (value) {
                              changeToSeconds(value.toInt());
                              value = value;
                            },
                            activeColor: Colors.blue.shade400,
                            inactiveColor: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        _duration.toString().split(".")[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (_isPlaying) {
                              widget.audioPlayer.stop();
                            } else {
                              widget.audioPlayer.play();
                            }
                            _isPlaying = !_isPlaying;
                          });
                        },
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 40.0,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            widget.audioPlayer.load();
                          },
                          icon: const Icon(
                            Icons.refresh_sharp,
                            size: 40.0,
                            color: Colors.white,
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
}
