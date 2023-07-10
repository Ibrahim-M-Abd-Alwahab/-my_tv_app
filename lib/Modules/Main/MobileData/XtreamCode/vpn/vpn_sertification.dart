import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_tv_app/Modules/Main/UsersList/Users_list.dart';
import 'package:sizer/sizer.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../../../loding_user_chanels_screen.dart';

String _verticalGroupValue = "ملف";

List<String> _status = [
  "ملف",
  "رابط m3u",
];

class VpnCertificationScreen extends StatefulWidget {
  static const roudName = "/VpnCertificationScreen";

  const VpnCertificationScreen();

  @override
  State<VpnCertificationScreen> createState() => _VpnCertificationScreen();
}

class _VpnCertificationScreen extends State<VpnCertificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 6.h),
          child: ListView(
            children: [
              Center(child: Image.asset('assets/iptv.png')),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Text(
                  'اضافة ملف شهادة  ',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
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
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue[900]),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(LodingUserChanelsScreen.roudName);
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
                            .pushNamed(UsersListScreen.roudName);
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
      ),
    );
  }
}
