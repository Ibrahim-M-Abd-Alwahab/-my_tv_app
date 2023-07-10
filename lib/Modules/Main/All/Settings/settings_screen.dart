import 'dart:developer';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tv_app/Models/user_data.dart';
import 'package:my_tv_app/provider/account_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:my_tv_app/Modules/Main/All/Settings/add_cirtification_file.dart';
import 'package:my_tv_app/Modules/Main/All/Settings/geniral_settings.dart';
import 'package:my_tv_app/Modules/Main/All/Settings/switch_device_mode.dart';
import 'package:my_tv_app/Modules/Main/All/Settings/time_style.dart';
import 'package:my_tv_app/Modules/Main/All/Settings/tv_program_guide.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  final UserData? userData;

  static const roudName = "/SettingsScreen";
  const SettingsScreen({
    this.userData,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String? dropdownvalue;

  Future getContent({dropdownvalue}) async {
    AccountProvider dataPre = ref.read(accountProvider);
    return await dataPre.selectdPlayer(dropdownvalue);
  }

  @override
  void initState() {
    getContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var items = [
      "Select Player",
      "Mx Player",
      "Vlc Player",
    ];

    String? timeNow = widget.userData!.serverInfo!.timeNow ?? "";
    log("timeNow $timeNow");

    // Format the timeNow string
    final formattedTime =
        DateFormat('HH:mm a \nd, yyyy MMMM').format(DateTime.parse(timeNow));

    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF394867),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formattedTime,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9BA4B5),
                    )),
                Row(
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff9BA4B5),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      '|',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: const Color(0xff9BA4B5),
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
          Container(
            // alignment: AlignmentDirectional.centerEnd,
            child: Expanded(
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      // maxCrossAxisExtent: 160,
                      childAspectRatio: 4 / 3,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                      crossAxisCount: 5,
                    ),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TimeStyleScreen(userData: widget.userData),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.w))),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.timelapse),
                              SizedBox(
                                height: 3.h,
                              ),
                              const Text('Time display mode'),
                            ],
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(TvProgramGuideScreen.roudName);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.w))),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.book),
                              SizedBox(
                                height: 3.h,
                              ),
                              const Text('TV Show Guide  '),
                            ],
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GeneralSettingScreen(
                                  userData: widget.userData),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.w))),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.settings),
                              SizedBox(
                                height: 3.h,
                              ),
                              const Text(' General Settings'),
                            ],
                          )),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.w))),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.control_camera_outlined),
                            SizedBox(
                              height: 3.h,
                            ),
                            const Text('تحكم الاهل'),
                          ],
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.w),
                        child: Column(
                          children: <Widget>[
                            DropdownButton(
                              elevation: 0,
                              dropdownColor: const Color(0xff9BA4B5),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              underline: Container(),
                              value: dropdownvalue ?? "Select Player",
                              iconEnabledColor: Colors.white,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) async {
                                getContent(dropdownvalue: newValue!);
                                setState(() {
                                  dropdownvalue = newValue;
                                });
                                if (newValue == "Mx Player") {
                                  await LaunchPlayer(
                                      'https://play.google.com/store/apps/details?id=com.mxtech.videoplayer.ad');
                                } else if (newValue == "VLc Player") {
                                  log("LaunchPlayer $newValue");
                                  await LaunchPlayer(
                                      'https://play.google.com/store/apps/details?id=org.videolan.vlc');
                                }
                                log(dropdownvalue ?? "Select Player");
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.w))),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.screen_rotation_alt),
                            SizedBox(
                              height: 3.h,
                            ),
                            const Text('شاشة متعددة'),
                          ],
                        )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.w))),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.home_max),
                            SizedBox(
                              height: 3.h,
                            ),
                            const Text('إعدادات المشغل الأساسي'),
                          ],
                        )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SwitchDeviceModeScreen.roudName);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.w))),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.switch_access_shortcut),
                              SizedBox(
                                height: 3.h,
                              ),
                              const Text('Switch Device Mode'),
                            ],
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AddCertificationFile.roudName);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.w))),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.vpn_key),
                              SizedBox(
                                height: 3.h,
                              ),
                              const Text('VPN'),
                            ],
                          )),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> LaunchPlayer(String link) async {
    Uri uri = Uri.parse(link);
    String idParameter = uri.queryParameters['id']!;
    // com.mxtech.videoplayer.ad
    bool isInstalled = await DeviceApps.isAppInstalled(idParameter);
    if (isInstalled) {
      log("App Was Installed");
    } else {
      if (await canLaunchUrl(uri)) {
        log("App No't Installed");

        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              behavior: SnackBarBehavior.floating,
              width: 300,
              content: Text(
                'Cannot launch the URL.',
                textAlign: TextAlign.center,
              )),
        );
      }
    }
  }
}
