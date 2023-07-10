import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FileMusicApp extends StatefulWidget {
  static const roudName = "/FileMusicApp";

  const FileMusicApp(
      {Key? key, required this.filePath, required this.NameOfSong})
      : super(key: key);
  final String filePath;
  final String NameOfSong;

  @override
  State<FileMusicApp> createState() => _FileMusicAppState();
}

class _FileMusicAppState extends State<FileMusicApp> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration _duration = const Duration();

  Duration _position = const Duration();

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    PlayFileMusic();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
  }

  void stop() async {
    await audioPlayer.dispose();
  }

  void PlayFileMusic() async {
    try {
      audioPlayer.setAudioSource(AudioSource.file(widget.filePath));
      audioPlayer.play();
      audioPlayer.setLoopMode(LoopMode.one);

      _isPlaying = true;
    } on Exception {
      log("Can't play selected Song");
    }
    audioPlayer.durationStream.listen((d) {
      if (mounted) {
        setState(() {
          _duration = d!;
        });
      }
    });
    audioPlayer.positionStream.listen((p) {
      if (mounted) {
        setState(() {
          _position = p;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 24, 37),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                  ),
                  const Text(
                    'Now Playing',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 50.0),
                ],
              ),
              const SizedBox(height: 20.0),
              const CircleAvatar(
                radius: 80.0,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.music_note,
                  size: 120.0,
                  color: Color.fromARGB(255, 35, 24, 37),
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                widget.NameOfSong,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              Column(
                children: [
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
                              audioPlayer.stop();
                            } else {
                              audioPlayer.play();
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
                          audioPlayer.load();
                        },
                        icon: const Icon(
                          Icons.refresh_sharp,
                          size: 40.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }
}
