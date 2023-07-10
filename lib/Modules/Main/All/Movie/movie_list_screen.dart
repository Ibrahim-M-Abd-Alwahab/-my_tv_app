// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:my_tv_app/Models/data_model.dart';
// import 'package:sizer/sizer.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../provider/date_provider.dart';
// import '../../../../utils/failure.dart';
// import '../../login_type.dart';
// import '../Settings/settings_screen.dart';
// import 'channel.dart';

// class MovieListScreen extends ConsumerStatefulWidget {
//   static const roudName = "/MovieListScreen";
//   final String urlink;
//   MovieListScreen({
//     super.key,
//     required this.urlink,
//   });

//   @override
//   _MovieListScreenState createState() => _MovieListScreenState();
// }

// int _value = 0;
// bool nameVisible = true;

// class _MovieListScreenState extends ConsumerState<MovieListScreen> {
//   late Future _fetchedData;

//   Future _getContentData() async {
//     //! get access to the DataProvider Class
//     final dataProv = ref.read(dataProvider);
//     //! call the getDataRequset method to get the data
//     return dataProv.getDataList?.resources?.isEmpty ?? false
//         ? await dataProv.getDataRequset(page: "1")
//         : true;
//   }

//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     _fetchedData = _getContentData();

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _scrollController.addListener(() async {
//         print("object");
//         final portalProv = ref.read(dataProvider);

//         if (_scrollController.position.pixels ==
//             _scrollController.position.maxScrollExtent) {
//           var portalRequset =
//               ref.watch(dataProvider).getDataList ?? ChannelData();
//           print("has more pages");
//           log("show currentPage" +
//               ((portalRequset.pagination?.currentPage ?? 0) + 1).toString());
//           await portalProv
//               .getDataRequset(
//                   page: ((portalRequset.pagination?.currentPage ?? 0) + 1)
//                       .toString())
//               .then((value) {
//             setState(() {});
//           });
//         }
//       });
//     });

//     super.initState();
//   }

//   void _showdropDownMenu(value) {
//     setState(() {
//       _value = value;
//       value == 1
//           ? nameVisible = !nameVisible
//           : value == 2
//               ? showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: const Text(
//                         "تأكيد التحديث",
//                         textAlign: TextAlign.end,
//                       ),
//                       content: const Text(
//                         "هل انت متأكد انك تريد تحديث القنوات",
//                         textAlign: TextAlign.end,
//                       ),
//                       actions: <Widget>[
//                         Container(
//                           color: Colors.red[200],
//                           child: TextButton(
//                             child: const Text(
//                               "تراجع",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ),
//                         Container(
//                           color: Colors.green,
//                           child: TextButton(
//                             child: const Text(
//                               "تحديث",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 )
//               : value == 3
//                   ? showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: const Text(
//                             "نمط الترتيب  ",
//                             textAlign: TextAlign.end,
//                           ),
//                           content: SizedBox(
//                             width: 50.w,
//                             height: 40.h,
//                             child: ListView(
//                               shrinkWrap: false,
//                               children: <Widget>[
//                                 for (int i = 1; i <= 5; i++)
//                                   ListTile(
//                                     title: Text(
//                                       'Radio $i',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .subtitle1
//                                           ?.copyWith(
//                                               color: i == 4
//                                                   ? Colors.black38
//                                                   : Colors.brown),
//                                     ),
//                                     leading: Radio(
//                                       value: i,
//                                       groupValue: _value,
//                                       onChanged: (value) {},
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                           actions: <Widget>[
//                             Container(
//                               color: Colors.red[200],
//                               child: TextButton(
//                                 child: Text(
//                                   "تراجع",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             ),
//                             Container(
//                               color: Colors.green,
//                               child: TextButton(
//                                 child: Text(
//                                   "تحديث",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     )
//                   : _value == 4
//                       ? Navigator.pushNamed(context, SettingsScreen.roudName)
//                       : _value == 5
//                           ? Navigator.of(context).pushNamedAndRemoveUntil(
//                               LoginTypeScreen.roudName,
//                               (Route<dynamic> route) => false)
//                           : _value = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Consumer(
//         builder: (context, ref, child) => FutureBuilder(
//           //! we use the future we created in the initState to get the data
//           future: _fetchedData,
//           builder: (context, snapshot) {
//             //! if data still loading show the loader
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return SizedBox(
//                 height: 70.h,
//                 child: const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             }
//             //! if there is an error show the error message
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             }

//             if (snapshot.hasData) {
//               if (snapshot.data is Failure) {
//                 return Center(child: Text(snapshot.data.toString()));
//               }
//               //! we get the data form dataProvider
//               //! and  handle the null value
//               var dataList =
//                   ref.watch(dataProvider).getDataList ?? ChannelData();
//               return Padding(
//                 padding: EdgeInsets.all(3.w),
//                 child: Column(
//                   children: [
//                     Container(
//                       // width: 220,
//                       // height: 50.h,
//                       // padding: EdgeInsets.all(3.w),
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 2.w, vertical: 2.w),
//                             alignment: Alignment.centerLeft,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       GestureDetector(
//                                           onTap: () {
//                                             Navigator.of(context).pop();
//                                           },
//                                           child: Icon(Icons.arrow_back_sharp)),
//                                       SizedBox(
//                                         width: 2.w,
//                                       ),
//                                       // IconButton(
//                                       //     icon: Icon(Icons.more_vert),
//                                       //     onPressed: () {}),
//                                       DropdownButton(
//                                         value: _value,
//                                         items: const <DropdownMenuItem<int>>[
//                                           DropdownMenuItem(
//                                             value: 0,
//                                             child: Text('   '),
//                                           ),
//                                           DropdownMenuItem(
//                                             value: 1,
//                                             child: Text('الصفحة الرئيسية',
//                                                 textAlign: TextAlign.end),
//                                           ),
//                                           DropdownMenuItem(
//                                             value: 2,
//                                             child: Text(
//                                               ' تحديث القنوات والأفلام والمسلسلات  ',
//                                               textAlign: TextAlign.end,
//                                             ),
//                                           ),
//                                           DropdownMenuItem(
//                                             value: 3,
//                                             child: Text('الترتيب',
//                                                 textAlign: TextAlign.start),
//                                           ),
//                                           DropdownMenuItem(
//                                             value: 4,
//                                             child: Text('الإعدادات',
//                                                 textAlign: TextAlign.end),
//                                           ),
//                                           DropdownMenuItem(
//                                             value: 5,
//                                             child: Text('تسجيل خروج',
//                                                 textAlign: TextAlign.end),
//                                           ),
//                                         ],
//                                         icon: const Icon(Icons.more_vert),

//                                         onChanged: (value) {
//                                           _showdropDownMenu(value);
//                                         },
//                                         // onChanged: (int value) {
//                                         //   _showdropDown(value);
//                                         // },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Container(
//                                     child: const Text('data'),
//                                     alignment: Alignment.centerLeft,
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 4.w,
//                                     ),
//                                     Image.asset(
//                                       'assets/iptv.png',
//                                       width: 20.w,
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 0.5.h, horizontal: 2.w),
//                           child: Container(
//                             width: 120.w,
//                             color: Colors.grey[100],
//                             child: Column(children: [
//                               Container(
//                                   color: Colors.amber,
//                                   width: double.infinity,
//                                   height: 5.h,
//                                   child: Text(
//                                     'تلفزيون مباشر',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 12.sp),
//                                   )),
//                               SizedBox(
//                                 height: 2.h,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   // Navigator.of(context).pushNamed(ChannelView.roudName,u);
//                                   // Navigator.pushNamed(
//                                   //   context,
//                                   //   ChannelView.roudName,
//                                   // );
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             ChannelView(widget.urlink),
//                                       ));
//                                 },
//                                 child: Container(
//                                   width: double.infinity,
//                                   height: 25.h,
//                                   color: Colors.blue,
//                                   child: Image.asset(
//                                     'assets/jazera.png',
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               ),
//                             ]),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 80.w,
//                           height: 32.h,
//                           child: Container(
//                             color: const Color.fromARGB(255, 253, 236, 220),
//                             child: Column(children: [
//                               Container(
//                                   color: Colors.amber,
//                                   height: 4.h,
//                                   child: const ListTile(
//                                     leading: Icon(Icons.skip_previous),
//                                     title: Center(child: Text('الكل')),
//                                     trailing: Icon(Icons.skip_next),
//                                   )),
//                               Expanded(
//                                 child: ListView.builder(
//                                     controller: _scrollController,
//                                     itemCount: dataList.resources?.length ?? 0,
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       return GestureDetector(
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     ChannelView(
//                                                       dataList.resources?[index]
//                                                               .urlLink ??
//                                                           '',
//                                                     )),
//                                           );
//                                         },
//                                         child: ListTile(
//                                           // leading: const Icon(Icons.list),
//                                           trailing: Container(
//                                             width: 35.w,
//                                             child: Row(
//                                               children: [
//                                                 Text(
//                                                   'لا يوجد برنامج',
//                                                   style:
//                                                       TextStyle(fontSize: 8.sp),
//                                                 ),
//                                                 // SizedBox(
//                                                 //   width: 1.w,
//                                                 // ),
//                                                 Image.asset(
//                                                   'assets/logoo.png',
//                                                   width: 8.w,
//                                                 ),
//                                                 // SizedBox(
//                                                 //   width: 1.w,
//                                                 // ),
//                                                 Text(
//                                                   dataList.resources?[index].id
//                                                           .toString() ??
//                                                       '',
//                                                   style: const TextStyle(
//                                                       color: Colors.green,
//                                                       fontSize: 12),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           title: Text(
//                                             dataList.resources?[index].name ??
//                                                 '',
//                                             style: TextStyle(fontSize: 12),
//                                           ),
//                                           leading: const Icon(
//                                             Icons.favorite,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                               ),
//                             ]),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             }
//             return Container();
//           },
//         ),
//       ),
//     ));
//   }
// }
