import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:my_tv_app/Modules/Main/MobileData/VideoLibrary/singel_vid.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';
import 'package:my_tv_app/Modules/Main/MobileData/VideoLibrary/videl_model.dart';

class AllVideoScreen extends StatefulWidget {
  static const roudName = "/AllVideoScreen";

  const AllVideoScreen({Key? key}) : super(key: key);

  @override
  State<AllVideoScreen> createState() => _AllVideoScreenState();
}

class _AllVideoScreenState extends State<AllVideoScreen> {
  Future? getData;
  Future<String?> getVideoPath() async {
    String? videoPath = "";
    try {
      videoPath = await StoragePath.videoPath;
      if (videoPath == null) return null;

      var response = jsonDecode(videoPath);
      var res = response as List<dynamic>;
      List<VideoModel> videos = [];
      for (var element in res) {
        videos.add(VideoModel.fromJson(element));
      }

      log("data data ${videos.first.files?.length}");

      for (var element in videos) {
        element.files?.forEach((e) {
          vedList.add(e);
        });
      }
      log("vedList data ${vedList.length}");
    } on PlatformException {
      videoPath = 'Failed to get path';
    }
    return videoPath;
  }

  @override
  void initState() {
    getData = getVideoPath();
    super.initState();
  }

  List<Files> vedList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 35, 24, 37),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'All ',
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ' video library  ',
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 141, 108, 147),
          elevation: 0,
        ),
        body: FutureBuilder(
          future: getData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: vedList.length,
                itemBuilder: (BuildContext context, int index) {
                  final video = vedList[index];
                  return Column(
                    children: [
                      VideoItem(
                        url: video.path ?? "",
                        title: video.displayName ?? "",
                      ),

                      // Spacer()
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // padding: EdgeInsets.all(10),
                          height: 0.1.h,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ));
  }

  Future<List<File>> getVideoFiles() async {
    final directory = await getExternalStorageDirectory();
    final videoExtensions = ['.mp4', '.avi', '.mkv', '.mov', '.wmv'];

    final videos = <File>[];
    final files = directory!.listSync(recursive: true);

    for (final file in files) {
      if (file is File && videoExtensions.contains(file.path.split('.').last)) {
        videos.add(file);
      }
    }
    return videos;
  }
}

class VideoItem extends StatefulWidget {
  final String url;
  final String title;
  const VideoItem({required this.url, required this.title});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.url))
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: _controller?.value.isInitialized == true
            ? SizedBox(
                width: 100.0,
                height: 56.0,
                child: VideoPlayer(_controller!),
              )
            : const CircularProgressIndicator(),
        title: Column(
          children: [
            Text(
              widget.title.split('/').last,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoApp(url: widget.url),
            ),
          );
        },
      ),
    );
  }
}
