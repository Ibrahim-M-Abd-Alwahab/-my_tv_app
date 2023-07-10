import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tv_app/Modules/Channels/singel_categ.dart';
import 'package:my_tv_app/provider/account_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/failure.dart';
import '../new_design/series_by_cate_id_screen.dart';

bool visible = false;
double width = 206.w;
Color color = const Color.fromARGB(255, 255, 229, 150);

class HomeChannelsScreen extends ConsumerStatefulWidget {
  String action;
  String url;
  static const roudName = "/HomeChannelsScreen";

  HomeChannelsScreen(this.action, this.url, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeChannelsScreenState createState() => _HomeChannelsScreenState();
}

class _HomeChannelsScreenState extends ConsumerState<HomeChannelsScreen> {
  late Future _fetchedData;
  List<Map<String, dynamic>>? newUserList;

  Future _getContentData() async {
    final dataProv = ref.read(accountProvider);
    log("UserUrl AccountProvider ${dataProv.userUrl}");
    log("UserUrl Passed ${widget.url}");

    return await dataProv.getUserDataByAction(
      url: "${widget.url}&action=${widget.action}",
      action: widget.action,
    );
  }

  @override
  void initState() {
    _fetchedData = _getContentData();
    super.initState();
  }

  void _showListTyps() {
    setState(() {
      width == 206.w ? width = 160.w : width = 206.w;
    });
  }

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
                        "تأكيد التحديث",
                        textAlign: TextAlign.end,
                      ),
                      content: const Text(
                        "هل انت متأكد انك تريد تحديث القنوات",
                        textAlign: TextAlign.end,
                      ),
                      actions: <Widget>[
                        Container(
                          color: Colors.red[200],
                          child: TextButton(
                            child: const Text(
                              "تراجع",
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
                              "تحديث",
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
                            "نمط الترتيب  ",
                            textAlign: TextAlign.end,
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
                                          .titleMedium
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
                                  "تراجع",
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
                                  "تحديث",
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
                var dataList =
                    ref.watch(accountProvider).getVodCategoriesList ?? [];
                return ListView(
                  children: [
                    SizedBox(
                      width: 220,
                      // height: 50.h,
                      // padding: EdgeInsets.all(3.w),
                      child: Column(
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
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    child: Text(
                                      'Channel',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xffF1F6F9),
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
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
                                      ),
                                    ),
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
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Container(
                            width: 190.w,
                            height: 35.7.h,
                            child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 4,
                                  crossAxisSpacing: 20, // between columns
                                  mainAxisSpacing: 10, // between rows
                                ),
                                itemCount: dataList.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (widget.action ==
                                          'get_vod_categories') {
                                        log('${ref.read(accountProvider).dropdownvalue.runtimeType}');
                                        log('${ref.read(accountProvider).dropdownvalue}');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return SingelCategScreen(
                                                url: widget.url,
                                                action: "get_vod_streams",
                                                id: dataList[index]
                                                    .categoryId
                                                    .toString(),
                                              );
                                            },
                                          ),
                                        );
                                      } else if (widget.action ==
                                          'get_series_categories') {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return SeriesByCateIdScreen(
                                            url: widget.url,
                                            id: dataList[index]
                                                .categoryId
                                                .toString(),
                                          );
                                        }));
                                      } else if (widget.action ==
                                          'get_live_categories') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SingelCategScreen(
                                              url: widget.url,
                                              action: "get_live_streams",
                                              id: dataList[index]
                                                  .categoryId
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 170,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 207, 206, 206),
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Text(
                                            dataList[index].categoryName ?? "",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromARGB(
                                                  255, 70, 70, 70),
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.favorite,
                                            color:
                                                Color.fromARGB(79, 108, 57, 93),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
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
