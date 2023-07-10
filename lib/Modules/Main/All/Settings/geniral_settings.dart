import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_tv_app/Models/user_data.dart';
import 'package:my_tv_app/provider/account_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:my_tv_app/Modules/Main/All/Settings/settings_screen.dart';

class GeneralSettingScreen extends ConsumerStatefulWidget {
  static const roudName = "/GeniralSettingScreen";
  final UserData? userData;

  const GeneralSettingScreen({@required this.userData, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GeneralSettingScreenState createState() => _GeneralSettingScreenState();
}

List<String> data = [
  "التشغيل التلقائي عند بدء التشغيل",
  "إظهار دليل البرامج التلفزيونية كاملا",
  "إظهار الترجمة",
  "صور في صور",
  "مسح ذاكرة التخزين المؤقت",
  "إظهار دليل البرامج الإلكتروني في قائمة القنوات "
];
List<String> userChecked = [];
final items = ['10', '20', '30', '40', '50'];
String selectedValue = '10';
final languqe = [
  'العربية',
  'English',
];
String selectedLang = 'English';

class _GeneralSettingScreenState extends ConsumerState<GeneralSettingScreen> {
  @override
  void initState() {
    super.initState();
    // Perform any initialization here
    ref.read(accountProvider);
  }

  void _onSelected(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        userChecked.add(dataName);
      });
    } else {
      setState(() {
        userChecked.remove(dataName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? timeNow = widget.userData!.serverInfo!.timeNow;

    // Format the timeNow string
    final formattedTime =
        DateFormat('HH:mm a \nd, yyyy MMMM').format(DateTime.parse(timeNow!));

    TextEditingController textEditingController;
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
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
                        'الاعدادات العامة',
                        style: TextStyle(
                          fontSize: 12.sp,
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
          Padding(
            padding: EdgeInsets.all(1.w),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 64.h,
              color: Colors.grey[300],
              child: Column(children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(data[0]),
                        Checkbox(
                          value: userChecked.contains(data[0]),
                          onChanged: (val) {
                            _onSelected(val!, data[0]);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(data[1]),
                        Checkbox(
                          value: userChecked.contains(data[1]),
                          onChanged: (val) {
                            _onSelected(val!, data[1]);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(data[2]),
                        Checkbox(
                          value: userChecked.contains(data[2]),
                          onChanged: (val) {
                            _onSelected(val!, data[2]);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(data[3]),
                        Checkbox(
                          value: userChecked.contains(data[3]),
                          onChanged: (val) {
                            _onSelected(val!, data[3]);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.w),
                            color: Colors.grey[200],
                          ),
                          child: TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("هل أنت واثق ؟"),
                                      content: const Text(
                                          "تريد مسح ذاكرة التخزين المؤقت"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: SizedBox(
                                            width: 10.w,
                                            child: const Text("لا"),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: SizedBox(
                                            width: 10.w,
                                            child: const Text("نعم"),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('واضح الان')),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(data[4]),
                        Checkbox(
                          value: userChecked.contains(data[4]),
                          onChanged: (val) {
                            _onSelected(val!, data[4]);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(data[5]),
                        Checkbox(
                          value: userChecked.contains(data[5]),
                          onChanged: (val) {
                            _onSelected(val!, data[5]);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton<String>(
                          value: selectedValue,
                          onChanged: (newValue) =>
                              setState(() => selectedValue = newValue!),
                          items: items
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                              .toList(),

                          // add extra sugar..
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 42,
                          underline: const SizedBox(),
                        ),
                        const Text(
                          'Channels History Limit',
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton<String>(
                          value: selectedLang,
                          onChanged: (newValue) =>
                              setState(() => selectedLang = newValue!),
                          items: languqe
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                              .toList(),

                          // add extra sugar..
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 42,
                          underline: const SizedBox(),
                        ),
                        const Text(
                          'اختيار لغة العرض',
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.h),
                    child: Container(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 4.h,
                              width: 80.w,
                              child: const TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            const Text('تعيين وكيل المستخدم'),
                          ],
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 90.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
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
                    Container(
                      width: 90.w,
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
                                'تعديل  ',
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
              ]),
            ),
          ),
        ],
      ),
    ));
  }
}
