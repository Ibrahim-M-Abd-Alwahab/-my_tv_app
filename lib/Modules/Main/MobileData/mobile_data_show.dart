import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_tv_app/Modules/Main/MobileData/LocalFolder/fileMusicApp.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'MusicLibrary/all_music_list.dart';
import 'VideoLibrary/all_videu_list.dart';

class MobileDataShow extends StatefulWidget {
  static const roudName = "/MobileDataShow";

  const MobileDataShow({Key? key}) : super(key: key);

  @override
  State<MobileDataShow> createState() => _MobileDataShowState();
}

class _MobileDataShowState extends State<MobileDataShow> {
  Future<bool> requestPermission(Permission setting) async {
    // if setting is already requested, it will return the status
    final result = await setting.request();
    switch (result) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission denied')),
        );
        return false;
    }
  }

  FilePickerResult? result;
  Future<String?> pickMusicFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      String? filePath = result!.files.single.path;
      return filePath;
    } else {
      return "";
    }
  }

  String? nameOfSong;
  String printArtistName() {
    if (result != null) {
      nameOfSong = result!.files.single.name;
      List<String> fileNameParts = nameOfSong!.split(".");
      String songName = fileNameParts.first;
      return songName;
    } else {
      return "UnKnown";
    }
  }

  @override
  Widget build(BuildContext context) {
    final AudioPlayer _audioPlayer = AudioPlayer();

    return Scaffold(
      backgroundColor: const Color(0xFF394867),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(3.w),
          width: 180.w,
          height: 50.h,
          child: Column(
            children: [
              Image.asset(
                'assets/iptv.png',
                width: 40.w,
                height: 7.h,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 50),
                  margin: EdgeInsets.all(4.w),
                  height: 20.h,
                  child: ListView(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 10.h,
                          child: CustomButton(
                            ' video library ',
                            (() {
                              Navigator.of(context).pushNamed(
                                AllVideoScreen.roudName,
                              );
                            }),
                            Colors.orange.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 10.h,
                          child: CustomButton(
                            ' music laibrary ',
                            (() async {
                              final canUseStorage =
                                  await requestPermission(Permission.storage);
                              if (canUseStorage) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context)
                                    .pushNamed(AllMusicScreen.roudName);
                              }
                            }),
                            Colors.green.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.h,
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: CustomButton(
                            'run local folder',
                            (() async {
                              final canUseStorage =
                                  await requestPermission(Permission.storage);
                              if (canUseStorage) {
                                String? filePath = await pickMusicFile();
                                String? NameOfSong = printArtistName();
                                // ignore: use_build_context_synchronously
                                if (filePath == "") {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('No File Selected')),
                                  );
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FileMusicApp(
                                        filePath: filePath!,
                                        NameOfSong: NameOfSong,
                                      ),
                                    ),
                                  );
                                }

                                log(filePath!);
                              }
                            }),
                            Colors.purple.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container CustomButton(
      String text, void Function()? onPressed, Color? color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color ?? Colors.orange.withOpacity(0.7),
      ),
      padding: EdgeInsets.all(1.h),
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
