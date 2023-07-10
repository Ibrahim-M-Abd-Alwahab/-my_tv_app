import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_tv_app/Modules/Main/All/Settings/settings_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../../loding_user_chanels_screen.dart';

class AddCertificationFile extends StatefulWidget {
  static const roudName = "/AddCertificationFile";

  const AddCertificationFile();

  @override
  State<AddCertificationFile> createState() => _AddCertificationFileState();
}

String _verticalGroupValue = "ملف";

List<String> _status = [
  "ملف",
  "رابط m3u",
];

class _AddCertificationFileState extends State<AddCertificationFile> {
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
                Container(
                  width: 50.w,
                  child: Row(
                    children: [
                      Icon(Icons.more_vert),
                      Icon(Icons.search),
                      Text('11:13 Am أكتوبر 24,2022 ')
                    ],
                  ),
                ),
                Container(
                  width: 20.w,
                  child: Text('data'),
                  alignment: Alignment.centerLeft,
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
                      'اضافة ملف شهادة  ',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Text(
                    ' نوع الشهادة ',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Container(
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
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Container(
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
          ),
        ]),
      ),
    );
  }
}
