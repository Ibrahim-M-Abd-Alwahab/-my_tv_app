import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'channels_multy_screen_list.dart';

class MultyScreen extends StatefulWidget {
  static const roudName = "/MultyScreen";

  const MultyScreen({Key? key}) : super(key: key);

  @override
  State<MultyScreen> createState() => _MultyScreenState();
}

class _MultyScreenState extends State<MultyScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[400],
      body: Padding(
        padding: EdgeInsets.all(3.h),
        child: Column(
          children: [
            const multiScreenContainer(),
            SizedBox(
              height: 2.h,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                multiScreenContainer(),
                multiScreenContainer(),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class multiScreenContainer extends StatelessWidget {
  const multiScreenContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ChannelsMultyScreen.roudName);
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(2.h),
          width: 85.w,
          height: 15.h,
          child: Icon(
            Icons.add_circle_outline_outlined,
            size: 5.h,
          ),
        ),
      ),
    );
  }
}
