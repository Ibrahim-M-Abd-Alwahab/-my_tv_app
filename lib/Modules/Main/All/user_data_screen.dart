import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_tv_app/Models/user_data.dart';
import 'package:sizer/sizer.dart';

class UserDataScreen extends ConsumerWidget {
  final UserData? userData;
  const UserDataScreen({
    @required this.userData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? username = userData!.userInfo!.username;
    String? status = userData!.userInfo!.status;
    String? isTrial = userData!.userInfo!.isTrial;

    String? activeCons = userData!.userInfo!.activeCons;
    String? maxConnections = userData!.userInfo!.maxConnections;
    String? expDate = userData!.userInfo!.expDate;
    DateTime formateExpDate = DateTime.now();
    if (expDate != null) {
      int timestamp = int.parse(expDate);
      formateExpDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    }

    String? createdAt = userData!.userInfo!.createdAt;
    DateTime formateCreatedAt = DateTime.now();
    String formattedDate = '';
    if (createdAt != null) {
      int newtimestamp = int.parse(createdAt);
      formateCreatedAt =
          DateTime.fromMillisecondsSinceEpoch(newtimestamp * 1000);
      formattedDate = DateFormat('yyyy-MM-dd').format(formateCreatedAt);
    }

    Duration calculateTimeDifference(DateTime start, DateTime end) {
      return end.difference(start);
    }

    Duration difference = calculateTimeDifference(
        DateTime.now().subtract(const Duration(days: 1)), formateExpDate);

    int differenceInDays = difference.inDays;
    log("differenceInDays: $differenceInDays Type Of Data ${differenceInDays.runtimeType}");

    // final BuildContext contextRef = context;

    // if (differenceInDays == 90) {
    //   log("true");
    //   SpHelper.spHelperObject.expireSub(username!, contextRef);
    // }

    log('Variables: $username $status $isTrial $activeCons $maxConnections $expDate $formattedDate');

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF394867),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    username!.substring(0, 1).toUpperCase() +
                        username.substring(1),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff9BA4B5),
                    ),
                  ),
                  Text(
                    ' | ',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff9BA4B5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Image.asset(
                    'assets/iptv.png',
                    width: 20.w,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Account Info',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff9BA4B5),
                  ),
                ),
              ),
            ),
            Container(
              width: 150.w,
              padding: EdgeInsets.only(
                left: 6.w,
              ),
              margin: EdgeInsets.all(6.w),
              height: 32.h,
              color: const Color(0xFFF1F6F9),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    dataListRow(
                      username.substring(0, 1).toUpperCase() +
                          username.substring(1),
                      'User Name :',
                    ),
                    dataListRow(
                      status,
                      'Accont Status :',
                    ),
                    dataListRow(
                      formattedDate,
                      'Create Acount Date :',
                    ),
                    dataListRow(
                      '$differenceInDays days',
                      'Subscription End Date',
                    ),
                    // ignore: unrelated_type_equality_checks
                    dataListRow(isTrial == 1 ? "Yes" : "No",
                        'Do You Have A Trial Subscription?'),
                    dataListRow(
                      maxConnections,
                      'The Number Of Devices Currently Active :',
                    ),

                    dataListRow(
                      activeCons,
                      'Max Device Number :',
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Padding dataListRow(data1, data2) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              data2,
              style: TextStyle(fontSize: 10.5.sp),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
              child: Text(
            data1,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.5.sp),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
