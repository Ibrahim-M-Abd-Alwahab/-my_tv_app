import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:my_tv_app/Models/user_data.dart';
import 'package:sizer/sizer.dart';
import 'package:my_tv_app/Modules/Main/All/Settings/settings_screen.dart';
import 'package:my_tv_app/provider/account_provider.dart';

class TimeStyleScreen extends ConsumerStatefulWidget {
  static const roudName = "/TimeStyleScreen";
  final UserData? userData;

  const TimeStyleScreen({@required this.userData, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TimeStyleScreenState createState() => _TimeStyleScreenState();
}

String _verticalGroupValue = "ملف";

List<String> _status = [
  "نمط عرض 12 ساعة",
  "نمط عرض 24 ساعة",
];

class _TimeStyleScreenState extends ConsumerState<TimeStyleScreen> {
  @override
  Widget build(BuildContext context) {
    String? timeNow = widget.userData!.serverInfo!.timeNow;

    // Format the timeNow string
    final formattedTime =
        DateFormat('HH:mm a \nd, yyyy MMMM').format(DateTime.parse(timeNow!));
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50.w,
                  child: Text(formattedTime,
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
                        'الاعدادات',
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
          SizedBox(height: 10.h),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: <Widget>[
                      RadioGroup<String>.builder(
                        groupValue: _verticalGroupValue,
                        onChanged: (value) => setState(() {
                          _verticalGroupValue = value!;
                        }),
                        items: _status,
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                          textPosition: RadioButtonTextPosition.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      child: Container(
                          width: 85.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue[900]),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(SettingsScreen.roudName);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'استيراد',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: Container(
                          width: 85.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue[900]),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(SettingsScreen.roudName);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'رجوع',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
