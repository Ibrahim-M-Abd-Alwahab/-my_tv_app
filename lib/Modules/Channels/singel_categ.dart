import 'dart:developer';
import 'package:external_video_player_launcher/external_video_player_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tv_app/Modules/Main/All/Movie/channel.dart';
import 'package:my_tv_app/provider/account_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import '../../utils/failure.dart';

bool visible = false;
double width = 206.w;
double listTypesWidth = 0;
Color color = const Color.fromARGB(255, 255, 229, 150);

class SingelCategScreen extends ConsumerStatefulWidget {
  String url;
  String action;
  String id;
  static const roudName = "/SingelCategScreen";

  SingelCategScreen({
    Key? key,
    required this.url,
    required this.action,
    required this.id,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SingelCategScreenState createState() => _SingelCategScreenState();
}

class _SingelCategScreenState extends ConsumerState<SingelCategScreen> {
  late Future _fetchedData;

  Future _getContentData() async {
    //! get access to the DataProvider Class
    final dataProv = ref.read(accountProvider);
    //! call the getDataRequset method to get the data
    return await dataProv.getUserDataByCateg(
      url: "${widget.url}&action=${widget.action}&category_id=${widget.id}",
      action: widget.action,
    );
  }

  FlickManager? flickManagerr;
  FlickControlManager? flickControlManager;
  dynamic streamId;

  // videoPlayerController() {
  //   flickManager = FlickManager(
  //     videoPlayerController: VideoPlayerController.network(
  //       streamId,
  //     ),
  //     autoPlay: true,
  //     getPlayerControlsTimeout: ({
  //       errorInVideo,
  //       isPlaying,
  //       isVideoEnded,
  //       isVideoInitialized,
  //     }) {
  //       return const Duration(seconds: 5);
  //     },
  //   );
  //   log("true");

  //   return flickManager;
  // }

  @override
  void initState() {
    _fetchedData = _getContentData();
    super.initState();
  }

  @override
  void dispose() async {
    await flickManagerr?.dispose();
    super.dispose();
  }

  void _showListTyps() {
    setState(() {
      width == 206.w ? width = 160.w : width = 206.w;
      width == 206.w ? listTypesWidth = 0 : listTypesWidth = width / 3.3;
    });
  }

  Color tabColor = Colors.white;
  int _value = 0;
  bool nameVisible = true;
  void _showdropDownMenu(value) {
    setState(() {
      _value = value;
      value == 1
          ? nameVisible = !nameVisible
          : value == 2
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Confirm update ",
                        textAlign: TextAlign.start,
                      ),
                      content: const Text(
                        "Are you sure you need Confirm update",
                        textAlign: TextAlign.start,
                      ),
                      actions: <Widget>[
                        Container(
                          color: Colors.red[200],
                          child: TextButton(
                            child: const Text(
                              "Retreat",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Container(
                          color: Colors.green,
                          child: TextButton(
                            child: const Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                )
              : value == 3
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "Sort style   ",
                            textAlign: TextAlign.start,
                          ),
                          content: SizedBox(
                            width: 50.w,
                            height: 40.h,
                            child: ListView(
                              shrinkWrap: false,
                              children: <Widget>[
                                for (int i = 1; i <= 5; i++)
                                  ListTile(
                                    title: Text(
                                      'Radio $i',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              color: i == 4
                                                  ? Colors.black38
                                                  : Colors.brown),
                                    ),
                                    leading: Radio(
                                      value: i,
                                      groupValue: _value,
                                      onChanged: (value) {},
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            Container(
                              color: Colors.red[200],
                              child: TextButton(
                                child: const Text(
                                  "retret",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Container(
                              color: Colors.green,
                              child: TextButton(
                                child: const Text(
                                  "update",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF394867),
        body: Consumer(
          builder: (context, ref, child) => FutureBuilder(
            //! we use the future we created in the initState to get the data
            future: _fetchedData,
            builder: (context, snapshot) {
              //! if data still loading show the loader
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 70.h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              //! if there is an error show the error message
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (snapshot.hasData) {
                if (snapshot.data is Failure) {
                  return Center(child: Text(snapshot.data.toString()));
                }
                //! we get the data form dataProvider
                //! and  handle the null value
                var dataList = ref.watch(accountProvider).getAllMovieist ?? [];

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 335,
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Icon(
                                        Icons.arrow_back_sharp,
                                        color: Color(0xffF1F6F9),
                                      )),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  // IconButton(
                                  //     icon: Icon(Icons.more_vert),
                                  //     onPressed: () {}),
                                  DropdownButton(
                                    dropdownColor: const Color(0xFF9BA4B5),
                                    iconEnabledColor: const Color(0xFF9BA4B5),
                                    menuMaxHeight: 500,
                                    value: _value,
                                    items: const [
                                      DropdownMenuItem(
                                        value: 0,
                                        child: Text(
                                          'No selection',
                                          style: TextStyle(
                                            color: Color(0xFFf1f6f9),
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Text(
                                          'Hide channel name',
                                          style: TextStyle(
                                            color: Color(0xFFf1f6f9),
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 2,
                                        child: Text(
                                          'Update channels, movies and series',
                                          style: TextStyle(
                                            color: Color(0xFFf1f6f9),
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 3,
                                        child: Text(
                                          'sort',
                                          style: TextStyle(
                                            color: Color(0xFFf1f6f9),
                                          ),
                                        ),
                                      ),
                                    ],
                                    icon: const Icon(Icons.more_vert),
                                    onChanged: (value) {
                                      _showdropDownMenu(value);
                                    },
                                    // onChanged: (int value) {
                                    //   _showdropDown(value);
                                    // },
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'channel ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xffF1F6F9),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      _showListTyps();
                                    },
                                    child: Image.asset(
                                      'assets/hamburger.png',
                                      color: const Color(0xFF9BA4B5),
                                    )),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Image.asset(
                                  'assets/iptv.png',
                                  width: 20.w,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Content
                      // Row(
                      //   children: [
                      //     const SizedBox(width: 10),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Container(
                      //         height: 38.h,
                      //         color: Colors.black.withOpacity(0.7),
                      //         child: ListView.builder(
                      //           itemCount: dataList.length,
                      //           itemBuilder: (BuildContext context, int index) {
                      //             return GestureDetector(
                      //               onTap: () async {
                      //                 // var url =  ref.read(accountProvider).userUrl;
                      //                 var url = widget.url;
                      //                 var getHostFormUrl =
                      //                     Uri.parse(url).origin;
                      //                 // get the username form url
                      //                 var username = Uri.parse(url)
                      //                     .queryParameters['username']
                      //                     .toString();
                      //                 var password = Uri.parse(url)
                      //                     .queryParameters['password']
                      //                     .toString();
                      //                 streamId = dataList[index].streamType ==
                      //                         "live"
                      //                     ? "$getHostFormUrl/$username/$password/${dataList[index].streamId}"
                      //                     : "$getHostFormUrl/${dataList[index].streamType}/$username/$password/${dataList[index].streamId}.mp4";
                      //                 String? dropdownvalue = ref
                      //                     .read(accountProvider)
                      //                     .dropdownvalue;

                      //                 if (dropdownvalue == "IPTV Player" ||
                      //                     dropdownvalue == "Select Player" ||
                      //                     dropdownvalue == "" ||
                      //                     dropdownvalue == "Vlc Player") {
                      //                 } else if (dropdownvalue == "Mx Player") {
                      //                   String videoTitle =
                      //                       dataList[index].name;

                      //                   Map<String, dynamic> videoMap = {
                      //                     "sources": [streamId],
                      //                     "title": videoTitle,
                      //                   };

                      //                   await ExternalVideoPlayerLauncher
                      //                       .launchMxPlayer(
                      //                     videoMap["sources"][0],
                      //                     MIME.applicationMp4,
                      //                     {"title": videoMap["title"]},
                      //                   );
                      //                 }
                      //                 log("streamId: $streamId");
                      //                 log("'flickManager'+ $flickManagerr");

                      //                 flickManagerr = FlickManager(
                      //                   videoPlayerController:
                      //                       VideoPlayerController.network(
                      //                     streamId,
                      //                   ),
                      //                   autoPlay: true,
                      //                   getPlayerControlsTimeout: ({
                      //                     errorInVideo,
                      //                     isPlaying,
                      //                     isVideoEnded,
                      //                     isVideoInitialized,
                      //                   }) {
                      //                     return const Duration(seconds: 5);
                      //                   },
                      //                 );
                      //                 setState(() {
                      //                   flickManagerr = flickManagerr;
                      //                 });
                      //                 log("'flickManager'+ $flickManagerr");
                      //               },
                      //               child: Container(
                      //                 padding: const EdgeInsets.only(
                      //                   left: 16,
                      //                   bottom: 12,
                      //                   top: 12,
                      //                 ),
                      //                 decoration: BoxDecoration(
                      //                   border: Border(
                      //                     bottom: BorderSide(
                      //                       color: Colors.grey.shade200,
                      //                       width: 1.0,
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 child: Row(
                      //                   children: [
                      //                     Text(
                      //                       '${index + 1}', // Add index + 1 to display numbers starting from 1
                      //                       style: const TextStyle(
                      //                         fontSize: 14,
                      //                         fontWeight: FontWeight.w400,
                      //                         color: Colors.white,
                      //                       ),
                      //                     ),
                      //                     const SizedBox(width: 10),
                      //                     Image.network(
                      //                       dataList[index].streamIcon ?? "",
                      //                       fit: BoxFit.contain,
                      //                       width: 30,
                      //                       height: 30,
                      //                       errorBuilder: (BuildContext context,
                      //                           Object exception,
                      //                           StackTrace? stackTrace) {
                      //                         return Container(
                      //                           width: 30,
                      //                           height: 30,
                      //                           padding:
                      //                               const EdgeInsets.all(4.0),
                      //                           decoration: BoxDecoration(
                      //                             shape: BoxShape.circle,
                      //                             border: Border.all(
                      //                               color: Colors.white,
                      //                               width: 1.0,
                      //                             ),
                      //                           ),
                      //                           child: ClipOval(
                      //                             child: Image.asset(
                      //                               'assets/iptv.png',
                      //                               width: 30,
                      //                             ),
                      //                           ),
                      //                         );
                      //                       },
                      //                       loadingBuilder: (
                      //                         context,
                      //                         child,
                      //                         loadingProgress,
                      //                       ) {
                      //                         if (loadingProgress == null) {
                      //                           return child;
                      //                         } else if (loadingProgress
                      //                                 .cumulativeBytesLoaded ==
                      //                             loadingProgress
                      //                                 .expectedTotalBytes) {
                      //                           // Image fully loaded
                      //                           return child;
                      //                         } else {
                      //                           // Show loading indicator or placeholder image
                      //                           return const CircularProgressIndicator();
                      //                         }
                      //                       },
                      //                     ),
                      //                     const SizedBox(width: 10),
                      //                     Expanded(
                      //                       child: Text(
                      //                         dataList[index].name ?? "",
                      //                         style: const TextStyle(
                      //                           fontSize: 14,
                      //                           fontWeight: FontWeight.w400,
                      //                           color: Colors.white,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     const Icon(
                      //                       Icons.arrow_forward_ios,
                      //                       color: Colors.white,
                      //                       size: 14,
                      //                     ),
                      //                     const SizedBox(width: 10),
                      //                   ],
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 20),
                      //     Expanded(
                      //       flex: 5,
                      //       child: Container(
                      //         height: 38.h,
                      //         color: Colors.black.withOpacity(0.5),
                      //         child: Center(
                      //           child: flickManagerr != null
                      //               ? FlickVideoPlayer(
                      //                   flickManager: flickManagerr!,
                      //                   preferredDeviceOrientationFullscreen: const [
                      //                     DeviceOrientation.landscapeLeft,
                      //                     DeviceOrientation.landscapeRight,
                      //                   ],
                      //                   systemUIOverlay: const [
                      //                     SystemUiOverlay.bottom,
                      //                     SystemUiOverlay.top,
                      //                   ],
                      //                   wakelockEnabled: true,
                      //                   // wakelockEnabledFullscreen: true,
                      //                 )
                      //               : const Text("NULL"),
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 20),
                      //   ],
                      // ),

                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: SizedBox(
                              width: 175.w,
                              height: 40.7.h,
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    mainAxisSpacing: 20.0,
                                    crossAxisSpacing: 10.0,
                                    childAspectRatio: 2.0,
                                  ),
                                  itemCount: dataList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        // var url =  ref.read(accountProvider).userUrl;
                                        var url = widget.url;
                                        var getHostFormUrl =
                                            Uri.parse(url).origin;
                                        // get the username form url
                                        var username = Uri.parse(url)
                                            .queryParameters['username']
                                            .toString();
                                        var password = Uri.parse(url)
                                            .queryParameters['password']
                                            .toString();
                                        log("vedioUrl: $getHostFormUrl/${dataList[index].streamType}/$username/$password/${dataList[index].streamId}.mp4");

                                        String? dropdownvalue = ref
                                            .read(accountProvider)
                                            .dropdownvalue;

                                        if (dropdownvalue == "IPTV Player" ||
                                            dropdownvalue == "Select Player" ||
                                            dropdownvalue == "" ||
                                            dropdownvalue == "Vlc Player") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChannelView(
                                                dataList[index].streamType ==
                                                        "live"
                                                    ? "$getHostFormUrl/$username/$password/${dataList[index].streamId}"
                                                    : "$getHostFormUrl/${dataList[index].streamType}/$username/$password/${dataList[index].streamId}.mp4",
                                              ),
                                            ),
                                          );
                                        } else if (dropdownvalue ==
                                            "Mx Player") {
                                          String videoUrl = dataList[index]
                                                      .streamType ==
                                                  "live"
                                              ? "$getHostFormUrl/$username/$password/${dataList[index].streamId}"
                                              : '$getHostFormUrl/${dataList[index].streamType}/$username/$password/${dataList[index].streamId}.mp4';
                                          log("videoUrl $videoUrl");
                                          String videoTitle =
                                              dataList[index].name;

                                          Map<String, dynamic> videoMap = {
                                            "sources": [videoUrl],
                                            "title": videoTitle,
                                          };

                                          await ExternalVideoPlayerLauncher
                                              .launchMxPlayer(
                                            videoMap["sources"][0],
                                            MIME.applicationMp4,
                                            {"title": videoMap["title"]},
                                          );
                                        }

                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => VlcPlayerNew(
                                        //       dataList[index].streamType ==
                                        //               "live"
                                        //           ? "$getHostFormUrl/$username/$password/${dataList[index].streamId}"
                                        //           : "$getHostFormUrl/${dataList[index].streamType}/$username/$password/${dataList[index].streamId}.mp4",
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: double.infinity,
                                            alignment: Alignment.topCenter,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Image.network(
                                              // dataList
                                              //       .resources?[index]
                                              //       .name ??
                                              dataList[index].streamIcon ?? "",
                                              fit: BoxFit.fill,
                                              width: double.infinity,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                // Show error message or fallback image
                                                return Image.asset(
                                                  'assets/image_Not_Found.png',
                                                  width: 60,
                                                );
                                              },
                                              loadingBuilder: (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else if (loadingProgress
                                                        .cumulativeBytesLoaded ==
                                                    loadingProgress
                                                        .expectedTotalBytes) {
                                                  // Image fully loaded
                                                  return child;
                                                } else {
                                                  // Show loading indicator or placeholder image
                                                  return const CircularProgressIndicator();
                                                }
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: double.infinity,
                                            alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 6.h,
                                                ),
                                                Container(
                                                  height: 2.h,
                                                  color: Colors.white,
                                                  child: Text(
                                                    dataList[index].name ?? "",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.favorite,
                                              color: Color.fromARGB(
                                                  79, 108, 57, 93),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),

                          // ListView(
                          //   children: [],
                          // ),

                          Visibility(
                            visible: listTypesWidth == 0 ? false : true,
                            child: SizedBox(
                                width: width / 3.3,
                                height: 35.7.h,
                                child: Container(
                                  color:
                                      const Color.fromARGB(255, 255, 249, 243),
                                  child: Column(children: [
                                    SizedBox(
                                      height: 4.h,
                                      child: const TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        color: tabColor,
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('0'),
                                              Text('الكل'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        color: tabColor,
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('0'),
                                              Text(' المفضلة '),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          color: tabColor,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('0'),
                                                Text('CHANNEL HISTORY'),
                                              ],
                                            ),
                                          ),
                                        )),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          color: tabColor,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('0'),
                                                Text('فئات غير مصنفة'),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ]),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
