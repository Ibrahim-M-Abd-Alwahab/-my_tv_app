// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tv_app/provider/account_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/failure.dart';
import '../Main/All/Movie/channel.dart';

final List<Map> myProducts =
    List.generate(1000, (index) => {"id": index, "name": "Product $index"})
        .toList();
bool visible = false;
double width = 206.w;
double listTypesWidth = 0;
Color color = const Color.fromARGB(255, 255, 229, 150);

class SingelCategStremingScreen extends ConsumerStatefulWidget {
  String action;
  String id;
  static const roudName = "/SingelCategStremingScreen";

  SingelCategStremingScreen({
    required this.action,
    required this.id,
  });

  @override
  _SingelCategStremingScreenState createState() =>
      _SingelCategStremingScreenState();
}

class _SingelCategStremingScreenState
    extends ConsumerState<SingelCategStremingScreen> {
  late Future _fetchedData;

  Future _getContentData() async {
    //! get access to the DataProvider Class
    final dataProv = ref.read(accountProvider);
    //! call the getDataRequset method to get the data
    return await dataProv.getStreamDataByAction(
        url:
            "${dataProv.userUrl}&action=${widget.action}&category_id=${widget.id}",
        action: widget.action);
  }

  @override
  void initState() {
    _fetchedData = _getContentData();
    super.initState();
  }

  void _showListTyps() {
    setState(() {
      width == 206.w ? width = 160.w : width = 206.w;
      width == 206.w ? listTypesWidth = 0 : listTypesWidth = width / 3.3;
    });
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

  // show the dialog

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: Scaffold(
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
                      Container(
                        // width: 220,
                        // height: 50.h,
                        // padding: EdgeInsets.all(3.w),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 2.w),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Icon(
                                                Icons.arrow_back_sharp)),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        // IconButton(
                                        //     icon: Icon(Icons.more_vert),
                                        //     onPressed: () {}),
                                        DropdownButton(
                                          value: _value,
                                          items: const <DropdownMenuItem<int>>[
                                            DropdownMenuItem(
                                              child: Text(''),
                                              value: 0,
                                            ),
                                            DropdownMenuItem(
                                              child: Text('إخفاء اسم  القناة'),
                                              value: 1,
                                            ),
                                            DropdownMenuItem(
                                              child: Text(
                                                  'تحديث القنوات والأفلام والمسلسلات'),
                                              value: 2,
                                            ),
                                            DropdownMenuItem(
                                              child: Text('الترتيب'),
                                              value: 3,
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
                                      child: const Text('القناة'),
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
                                              'assets/hamburger.png')),
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
                            child: SizedBox(
                              width: width,
                              height: 35.7.h,
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 160,
                                          childAspectRatio: 4 / 3,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 20),
                                  itemCount: dataList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigator.of(context).pushNamed(
                                        //   MovieListScreen,
                                        // );
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           MovieListScreen(
                                        //             urlink: dataList
                                        //                     .resources?[index]
                                        //                     .urlLink ??
                                        //                 "",
                                        //           )),
                                        // );

                                        var url =
                                            ref.read(accountProvider).userUrl;

                                        var getHostFormUrl =
                                            Uri.parse(url).origin;
                                        // get the username form url
                                        var username = Uri.parse(url)
                                            .queryParameters['username']
                                            .toString();
                                        var password = Uri.parse(url)
                                            .queryParameters['password']
                                            .toString();

                                        print(
                                            "$getHostFormUrl/${dataList[index].streamType}/$username/$password/${dataList[index].streamId}.mp4");

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChannelView(
                                                    "$getHostFormUrl/${dataList[index].streamType}/$username/$password/${dataList[index].streamId}.mp4",
                                                  )),
                                        );
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: double.infinity,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Text(
                                                // dataList
                                                //       .resources?[index]
                                                //       .name ??
                                                dataList[index].name ?? ""),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.favorite,
                                              color: Colors.white,
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
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
