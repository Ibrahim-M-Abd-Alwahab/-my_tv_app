import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../Models/serise_info.dart';
import '../../provider/account_provider.dart';
import '../../utils/failure.dart';
import '../Main/All/Movie/channel.dart';

class SeriesInfoByIdScreen extends ConsumerStatefulWidget {
  String action = 'get_series_info';
  final String id;
  final String? url;
  SeriesInfoByIdScreen({required this.url, required this.id});

  @override
  _SeriesInfoByIdScreenState createState() => _SeriesInfoByIdScreenState();
}

class _SeriesInfoByIdScreenState extends ConsumerState<SeriesInfoByIdScreen> {
  late Future _fetchedData;
  late Future _fetchedDataMovie;

  Future _getContentData() async {
    //! get access to the DataProvider Class
    final dataProv = ref.read(accountProvider);
    //! call the getDataRequset method to get the data
    return await dataProv.getSeriesDataById(
        url: "${widget.url}&action=${widget.action}&series_id=${widget.id}}",
        action: widget.action);
  }

  // Future _getMoveContentData() async {
  //   //! get access to the DataProvider Class
  //   final dataProv = ref.read(accountProvider);
  //   //! call the getDataRequset method to get the data
  //   return await dataProv.getSiresDataByAction(
  //       url: "${dataProv.userUrl}&action=${widget.action}&category_id=$id",
  //       action: widget.action);
  // }

  @override
  void initState() {
    _fetchedData = _getContentData();
    //   _fetchedDataMovie = _getMoveContentData();
    super.initState();
  }

  String? seasonsNumber;
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeRight,
    // ]);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              width: double.infinity,
              //  height: 5.h,
              child: Consumer(
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
                      var dataList =
                          ref.watch(accountProvider).getSerisInfoModel ??
                              SerisInfoModel();

                      // dataList.episodes? get firt key
                      dataList.episodes?.forEach((key, value) {
                        log("key key $key");
                        seasonsNumber ??= key;
                      });
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                '${dataList.info?.cover}',
                                height: 40.h,
                                width: 55.w,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                dataList.info?.name ?? "",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              ),
                            ],
                          ),

                          // list view

                          if (dataList.seasons?.isNotEmpty ?? false)
                            SizedBox(
                              width: 30.h,
                              child: ListView.builder(
                                  itemCount: dataList.seasons?.length ?? 0,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        seasonsNumber = dataList
                                            .seasons?[index].seasonNumber
                                            .toString();
                                        setState(() {});
                                      },
                                      child: Container(
                                        child: Text(
                                            dataList.seasons?[index].name ??
                                                ""),
                                      ),
                                    );
                                  }),
                            ),

                          // list view
                          SizedBox(
                            width: 30.h,
                            child: ListView.builder(
                                itemCount: dataList
                                        .episodes?['$seasonsNumber']?.length ??
                                    0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      print(dataList
                                          .episodes?['$seasonsNumber']?[index]
                                          .title);
                                      print(dataList
                                          .episodes?['$seasonsNumber']?[index]
                                          .id);

                                      // var url =
                                      //     ref.read(accountProvider).userUrl;

                                      var url = widget.url;

                                      var getHostFormUrl =
                                          Uri.parse(url!).origin;
                                      // get the username form url
                                      var username = Uri.parse(url)
                                          .queryParameters['username']
                                          .toString();
                                      var password = Uri.parse(url)
                                          .queryParameters['password']
                                          .toString();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChannelView(
                                                  "$getHostFormUrl/series/$username/$password/${dataList.episodes?['$seasonsNumber']?[index].id}.${dataList.episodes?['$seasonsNumber']?[index].containerExtension}",
                                                )),
                                      );
                                    },
                                    child: SizedBox(
                                      width: 30.h,
                                      child: ListView.builder(
                                          itemCount: dataList
                                                  .episodes?['$seasonsNumber']
                                                  ?.length ??
                                              0,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                print(dataList
                                                    .episodes?['$seasonsNumber']
                                                        ?[index]
                                                    .title);
                                                print(dataList
                                                    .episodes?['$seasonsNumber']
                                                        ?[index]
                                                    .id);

                                                // var url = ref
                                                //     .read(accountProvider)
                                                //     .userUrl;
                                                var url = widget.url!;
                                                var getHostFormUrl =
                                                    Uri.parse(url).origin;
                                                // get the username form url
                                                var username = Uri.parse(url)
                                                    .queryParameters['username']
                                                    .toString();
                                                var password = Uri.parse(url)
                                                    .queryParameters['password']
                                                    .toString();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChannelView(
                                                            "$getHostFormUrl/series/$username/$password/${dataList.episodes?['$seasonsNumber']?[index].id}.${dataList.episodes?['$seasonsNumber']?[index].containerExtension}",
                                                          )),
                                                );
                                              },
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(3.w),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.w),
                                                            color:
                                                                Colors.purple),
                                                        child: Text(dataList
                                                                .episodes?[
                                                                    '$seasonsNumber']
                                                                    ?[index]
                                                                .episodeNum
                                                                .toString() ??
                                                            ""),
                                                      ),
                                                      Text(dataList
                                                              .episodes?[
                                                                  '$seasonsNumber']
                                                                  ?[index]
                                                              .title ??
                                                          ""),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

//   }
// }
  }
}
