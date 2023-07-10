import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tv_app/Modules/new_design/series_info_by_id_screen.dart';
import 'package:sizer/sizer.dart';

import '../../provider/account_provider.dart';
import '../../utils/failure.dart';

class SeriesByCateIdScreen extends ConsumerStatefulWidget {
  String action = 'get_series';
  final String id;
  final String url;
  SeriesByCateIdScreen({required this.id, required this.url});

  @override
  _SeriesByCateIdScreenState createState() => _SeriesByCateIdScreenState();
}

bool visible = false;
double width = 206.w;
double listTypesWidth = 0;
Color color = const Color.fromARGB(255, 255, 229, 150);

class _SeriesByCateIdScreenState extends ConsumerState<SeriesByCateIdScreen> {
  late Future _fetchedData;
  late Future _fetchedDataMovie;

  Future _getContentData() async {
    //! get access to the DataProvider Class
    final dataProv = ref.read(accountProvider);
    //! call the getDataRequset method to get the data
    return await dataProv.getSiresDataByCateId(
        url: "${widget.url}&action=${widget.action}&category_id=${widget.id}",
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

  final int _radioValue = 1;
  Color tabColor = Colors.white;
  int tabSelected = 0;
  bool isTap = false;
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF394867),
        body: ListView(
          children: [
            Container(
              width: double.infinity,
              child: Consumer(
                builder: (context, ref, child) => FutureBuilder(
                  //! we use the future we created in the initState to get the data
                  future: _fetchedData,
                  builder: (context, snapshot) {
                    //! if data still loading show the loader
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
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
                          ref.watch(accountProvider).getSeriesCateIdList ?? [];
                      log("dataList ${dataList.length}");

                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 2.w),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
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
                                          child: Text('No selection',
                                              style: TextStyle(
                                                  color: Color(0xFFf1f6f9))),
                                        ),
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text(
                                            'Hide the channel name',
                                            style: TextStyle(
                                              color: Color(0xffF1F6F9),
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 2,
                                          child: Text(
                                            'Update channels, movies and series',
                                            style: TextStyle(
                                              color: Color(0xffF1F6F9),
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 3,
                                          child: Text(
                                            'Sort',
                                            style: TextStyle(
                                              color: Color(0xffF1F6F9),
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
                                          // _showListTyps();
                                        },
                                        child: Image.asset(
                                          'assets/hamburger.png',
                                          color: const Color(0xFFf1f6f9),
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
                          SizedBox(
                            height: 45.h,
                            child: Padding(
                              padding: EdgeInsets.all(2.w),
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 240,
                                          childAspectRatio: 4 / 1,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 20),
                                  itemCount: dataList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Container(
                                      color: Colors.white,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return SeriesInfoByIdScreen(
                                              url: widget.url,
                                              id: dataList[index]
                                                  .seriesId
                                                  .toString(),
                                            );
                                          }));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Text(
                                                      dataList[index]
                                                          .rating5based
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                                Text(dataList[index].name),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
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
