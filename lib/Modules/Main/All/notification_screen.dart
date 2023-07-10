import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_tv_app/Models/user_data.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen(this.userData, {Key? key}) : super(key: key);
  final UserData userData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // String? timeNow =
    //     ref.watch(accountProvider).userdataModel!.serverInfo!.timeNow;
    String? timeNow = userData.serverInfo!.timeNow;

    // Format the timeNow string
    final formattedTime =
        DateFormat('HH:mm a \nd, yyyy MMMM').format(DateTime.parse(timeNow!));
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50.w,
                    child: Text(formattedTime ?? "",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff9BA4B5),
                        )),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'الإشعارات',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        '|',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                        ),
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
            Text(
              'لا يوجد بيانات حاليا ',
              style: TextStyle(fontSize: 10.sp),
            )
          ],
        ),
      ),
    );
  }
}
