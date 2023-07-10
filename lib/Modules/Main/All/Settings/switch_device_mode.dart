import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:group_radio_button/group_radio_button.dart';
import 'package:sizer/sizer.dart';
import 'package:my_tv_app/Modules/Main/All/Settings/settings_screen.dart';

class SwitchDeviceModeScreen extends StatefulWidget {
  static const roudName = "/SwitchDeviceModeScreen";

  const SwitchDeviceModeScreen({Key? key}) : super(key: key);

  @override
  State<SwitchDeviceModeScreen> createState() => _SwitchDeviceModeScreen();
}

String _verticalGroupValue = "ملف";

List<String> _status = [
  "TV",
  " MOBILE",
];

class _SwitchDeviceModeScreen extends State<SwitchDeviceModeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
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
                  width: 20.w,
                  alignment: Alignment.centerLeft,
                  child: const Text('SwitchDevice'),
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
          Expanded(
            child: ListView(
              children: [
                // Center(child: Image.asset('assets/iptv.png')),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Center(
                    child: Text(
                      'SwitchDeviceModeScreen ',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Center(
                    child: Text(
                      'Please choose correct one for better performance ',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Container(
                    child: _verticalGroupValue == 'رابط m3u'
                        ? TextField(
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              hintText: 'أدخل الرابط ',
                              hintStyle: TextStyle(
                                  color: Colors.blueGrey, fontSize: 10.sp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(2.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey)),
                            child: Text(
                              'حمل الملف',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
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
                          width: 80.w,
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
                                'استيراد ',
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
                          width: 80.w,
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
                                ' رجوع ',
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
