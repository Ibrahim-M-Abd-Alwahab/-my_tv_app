import 'dart:developer';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChannelView extends StatefulWidget {
  static const roudName = "/ChannelView";
  String urlink;

  ChannelView(
    this.urlink,
  );

  @override
  State<ChannelView> createState() => _ChannelViewState();
}

class _ChannelViewState extends State<ChannelView> {
  late FlickManager flickManager;
  FlickControlManager? flickControlManager;

  videoPlayerController() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        widget.urlink,
      ),
      autoPlay: true,
      getPlayerControlsTimeout: ({
        errorInVideo,
        isPlaying,
        isVideoEnded,
        isVideoInitialized,
      }) {
        return const Duration(seconds: 5);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    log("urlink ${widget.urlink}");
    videoPlayerController();
  }

  @override
  void dispose() async {
    super.dispose();
    await flickManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    bool _isBottomSheetOpen = false;
    void _toggleBottomSheet() {
      setState(() {
        _isBottomSheetOpen = !_isBottomSheetOpen;
      });
    }

    void showLeftSideBar(BuildContext context) {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey.withOpacity(0.5),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {},
                ),
              ],
            ),
          );
        },
      );
    }

    return Stack(
      children: [
        Scaffold(
          body: FlickVideoPlayer(
            flickManager: flickManager,
            // flickVideoWithControls: FlickVideoWithControls(
            //   videoFit: BoxFit.cover,
            //   controls: CustomOrientationControls(
            //     fullScreen: enterFullScreen,
            //   ),
            // ),
            // flickVideoWithControlsFullscreen: FlickVideoWithControls(
            //   videoFit: BoxFit.fill,
            //   controls: SafeArea(
            //       child: CustomOrientationControls(
            //     fullScreen: enterFullScreen,
            //   )),
            // ),
            preferredDeviceOrientationFullscreen: const [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ],
            systemUIOverlay: const [
              SystemUiOverlay.bottom,
              SystemUiOverlay.top,
            ],
            wakelockEnabled: true, wakelockEnabledFullscreen: true,
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: const Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   top: 30,
        //   left: 20,
        //   child: _isBottomSheetOpen == false
        //       ? GestureDetector(
        //           onTap: () {
        //             showLeftSideBar(context);
        //           },
        //           child: const Icon(
        //             Icons.menu,
        //             color: Colors.white,
        //             size: 30,
        //           ),
        //         )
        //       : Container(),
        // )
      ],
    );
  }
}
