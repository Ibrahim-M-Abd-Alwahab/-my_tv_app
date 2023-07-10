import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TvProgramGuideScreen extends StatefulWidget {
  static const roudName = "/TvProgramGuideScreen";

  const TvProgramGuideScreen();

  @override
  State<TvProgramGuideScreen> createState() => _TvProgramGuideScreenState();
}

class _TvProgramGuideScreenState extends State<TvProgramGuideScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50.w,
                    child: const Row(
                      children: [
                        Icon(Icons.more_vert),
                        Icon(Icons.search),
                        Text('11:13 Am أكتوبر 24,2022 ')
                      ],
                    ),
                  ),
                  Container(
                    width: 30.w,
                    alignment: Alignment.centerLeft,
                    child: const Text('دليل البرامج التلفزيونية  '),
                  ),
                  Row(
                    children: [
                      Text(
                        'الاعدادات',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        '|',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(
                        width: 2.w,
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
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.w),
                          color: Colors.grey[100],
                          height: 8.h,
                          width: 130.w,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Icon(Icons.add), Text('data')],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          color: Colors.grey[100],
                          height: 22.h,
                          width: 130.w,
                          child: const Text(
                            'لا يوجد مصادر حاليا',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.grey[100],
                    height: 31.h,
                    width: 55.w,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.amber[100]),
                          child: TextButton(
                            child: const Text(
                              'EPG مصادر ',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.amber[100]),
                          child: TextButton(
                            child: const Text(
                              'إعدادات دليل البرامج التلفزيونية  ',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        const Text('data'),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.amber[100]),
                          child: TextButton(
                            child: const Text(
                              'EPG TIMESHIFT',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        const Text('data'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
