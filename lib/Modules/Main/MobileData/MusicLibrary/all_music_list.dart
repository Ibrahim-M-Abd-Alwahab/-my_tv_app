import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_tv_app/Modules/Main/MobileData/MusicLibrary/singel_mus.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:sizer/sizer.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllMusicScreen extends StatefulWidget {
  static const roudName = "/AllMusicScreen";

  const AllMusicScreen({Key? key}) : super(key: key);

  @override
  State<AllMusicScreen> createState() => _AllMusicScreenState();
}

class _AllMusicScreenState extends State<AllMusicScreen> {
  bool permissionGranted = false;

  Future<void> requestPermission() async {
    final status = await Permission.storage.request();
    try {
      if (status.isGranted) {
        setState(() {
          permissionGranted = true;
        });
      } else if (status.isDenied) {
        // Handle the case where the user denies the permission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permission denied')),
        );
      } else if (status.isPermanentlyDenied) {
        // Handle the case where the user permanently denies the permission
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permission denied'),
            content: const Text('Please grant the storage permission manually'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => openAppSettings(),
                child: const Text('Open settings'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      log('Exception $e');
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final OnAudioQuery onAudioQuery = OnAudioQuery();

    final AudioPlayer _audioPlayer = AudioPlayer();

    PlaySong(String? uri) {
      try {
        _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
        _audioPlayer.play();
      } on Exception {
        log("Error Parsing song");
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xff9BA4B5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF394867),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 14),
          child: Text(
            'All',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 8),
            child: Text(
              ' music library  ',
              style: TextStyle(
                color: const Color(0xffF1F6F9),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: FutureBuilder<List<SongModel>>(
        future: onAudioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (item.data!.isEmpty) {
            return const Center(child: Text('No song found'));
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (BuildContext context, int songIndex) {
                  return Column(
                    children: [
                      Container(
                        height: 10.h,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xff394867),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(1.h),
                            child: ListTile(
                              leading: const Icon(
                                Icons.music_note,
                                color: Color(0xff394867),
                                size: 30,
                              ),
                              title: Text(
                                item.data![songIndex].displayNameWOExt,
                                style: TextStyle(
                                  color: const Color(0xff394867),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              subtitle: Text(
                                item.data![songIndex].artist == "<unknown>"
                                    ? "UnKnown Artist"
                                    : item.data![songIndex].artist.toString(),
                                style: TextStyle(
                                  color: const Color(0xff394867),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {
                                PlaySong(item.data![songIndex].uri);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MusicApp(
                                        songModel: item.data![songIndex],
                                        audioPlayer: _audioPlayer,
                                      );
                                    },
                                  ),
                                );
                              },
                            )),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  );
                }),
          );
        },
      ),
    );
  }
}
