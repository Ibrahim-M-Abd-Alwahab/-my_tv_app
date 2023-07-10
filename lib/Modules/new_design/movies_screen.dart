import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../provider/account_provider.dart';
import '../../utils/failure.dart';

class MoviesScreen extends ConsumerStatefulWidget {
  String action = 'get_vod_categories';
  MoviesScreen();

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends ConsumerState<MoviesScreen> {
  late Future _fetchedDataMovie;

  String id = '10';

  Future _getMoveContentData() async {
    //! get access to the DataProvider Class
    final dataProv = ref.read(accountProvider);
    //! call the getDataRequset method to get the data
    return await dataProv.getMoviesDataByAction(
        url: "${dataProv.userUrl}&action=${widget.action}&category_id=$id",
        action: widget.action);
  }

  @override
  void initState() {
    _fetchedDataMovie = _getMoveContentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // SizedBox(
            //   width: double.infinity,
            //   height: 5.h,
            //   child: Consumer(
            //     builder: (context, ref, child) => FutureBuilder(
            //       //! we use the future we created in the initState to get the data
            //       future: _fetchedData,
            //       builder: (context, snapshot) {
            //         //! if data still loading show the loader
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return SizedBox(
            //             height: 70.h,
            //             child: const Center(
            //               child: CircularProgressIndicator(),
            //             ),
            //           );
            //         }
            //         //! if there is an error show the error message
            //         if (snapshot.hasError) {
            //           return Center(
            //             child: Text('Error: ${snapshot.error}'),
            //           );
            //         }

            //         if (snapshot.hasData) {
            //           if (snapshot.data is Failure) {
            //             return Center(child: Text(snapshot.data.toString()));
            //           }
            //           //! we get the data form dataProvider
            //           //! and  handle the null value
            //           var dataList =
            //               ref.watch(accountProvider).getVodCategoriesList ?? [];

            //           return Expanded(
            //             child: ListView.builder(
            //               scrollDirection: Axis.horizontal,
            //               itemCount: dataList.length,
            //               itemBuilder: (context, index) {
            //                 return Padding(
            //                   padding: EdgeInsets.all(0.5.w),
            //                   child: GestureDetector(
            //                     onTap: () async {
            //                       id = dataList[index].categoryId.toString();
            //                       print(id);

            //                       final dataProv = ref.read(accountProvider);
            //                       //! call the getDataRequset method to get the data
            //                       await dataProv.getSiresDataByAction(
            //                           url:
            //                               "${dataProv.userUrl}&action=get_series_info&series_id=$id",
            //                           action: widget.action);
            //                     },
            //                     child: Container(
            //                       width: 35.w,
            //                       height: 5.h,
            //                       decoration: BoxDecoration(
            //                           color: const Color.fromARGB(
            //                               255, 255, 213, 0),
            //                           borderRadius: BorderRadius.circular(15)),
            //                       child: Padding(
            //                         padding: EdgeInsets.all(1.w),
            //                         child: Container(
            //                           alignment: Alignment.center,
            //                           child: Text(
            //                             dataList[index].categoryName.toString(),
            //                             textAlign: TextAlign.center,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 );
            //               },
            //             ),
            //           );
            //         }
            //         return Container();
            //       },
            //     ),
            //   ),
            // ),

            Consumer(
              builder: (context, ref, child) => FutureBuilder(
                //! we use the future we created in the initState to get the data
                future: _fetchedDataMovie,
                builder: (context, snapshot) {
                  //! if data still loading show the loader
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 65.h,
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

                    var dataListMove =
                        ref.watch(accountProvider).getAllMovieist ?? [];

                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dataListMove.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(0.5.w),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 35.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 255, 213, 0),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: EdgeInsets.all(1.w),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      dataListMove[index].name,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );

//   }
// }
  }
}
