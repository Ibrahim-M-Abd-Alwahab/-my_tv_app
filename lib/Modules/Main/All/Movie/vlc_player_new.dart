import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

class VlcPlayerNew extends StatefulWidget {
  String? urlink;

  VlcPlayerNew(this.urlink, {Key? key}) : super(key: key);

  @override
  _VlcPlayerNewState createState() => _VlcPlayerNewState();
}

class _VlcPlayerNewState extends State<VlcPlayerNew> {
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.urlink!)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then(
        (value) => controller!.play(),
      );
    setLandscape();
  }

  @override
  void dispose() {
    controller!.dispose();
    setAllOrientations();
    super.dispose();
  }

  Future setLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    await Wakelock.enable();
  }

  Future setAllOrientations() async {
    await Wakelock.disable();
  }

  // String getPosition() {
  //   final duration = Duration(
  //     milliseconds: controller!.value.position.inMilliseconds.round(),
  //   );
  //   return [duration.inMinutes, duration.inSeconds]
  //       .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
  //       .join(':');
  // }

  String getPosition() {
    final position = controller!.value.position;
    final duration = controller!.value.duration;

    final startPosition =
        Duration(milliseconds: position.inMilliseconds.round());
    final endPosition = Duration(milliseconds: duration.inMilliseconds.round());

    return '${formatDuration(startPosition)} / ${formatDuration(endPosition)}';
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  Widget buildIndicator() {
    return VideoProgressIndicator(controller!, allowScrubbing: true);
  }

  Widget buildPlay() {
    return controller!.value.isPlaying
        ? Container()
        : Container(
            alignment: Alignment.center,
            color: Colors.black26,
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 80),
          );
  }

  @override
  Widget build(BuildContext context) {
    final size = controller!.value.size;
    final width = size.width;
    final height = size.height;
    return controller != null && controller!.value.isInitialized
        ? Container(
            alignment: Alignment.topCenter,
            child: Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.cover,
                  child: Container(
                    color: Colors.red,
                    width: width,
                    height: height,
                    child: AspectRatio(
                      aspectRatio: controller!.value.aspectRatio,
                      child: VideoPlayer(controller!),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    // accountProvider.iconOnTap(
                    //   context: context,
                    //   warning: false,
                    //   text: 'Louck',
                    //   content:
                    //       'You need to purchase a Premium subscription to take advantage of these features',
                    //   done: "Subscription",
                    //   onPressed: () => Navigator.of(context).pop(),
                    // );
                    controller!.value.isPlaying
                        ? controller!.pause()
                        : controller!.play();
                  },
                  child: Stack(
                    children: <Widget>[
                      buildPlay(),
                      Positioned(
                        left: 12,
                        bottom: 20,
                        child: Text(
                          getPosition(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 12,
                        right: 10,
                        child: Row(
                          children: [
                            Expanded(child: buildIndicator()),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
