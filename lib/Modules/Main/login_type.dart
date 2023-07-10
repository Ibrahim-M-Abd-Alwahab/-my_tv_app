import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tv_app/Modules/Main/MobileData/XtreamCode/xtream_code_login_screen.dart';
import 'package:my_tv_app/helpers/sp_helper.dart';
// ignore: depend_on_referenced_packages
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'LinkOrChannelsFolder/link_or_channel_folder.dart';
import 'MobileData/mobile_data_show.dart';
import 'UsersList/Users_list.dart';

class LoginTypeScreen extends StatefulWidget {
  static const roudName = "/LoginTypeScreen";

  const LoginTypeScreen({Key? key}) : super(key: key);

  @override
  State<LoginTypeScreen> createState() => _LoginTypeScreenState();
}

class _LoginTypeScreenState extends State<LoginTypeScreen> {
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF394867),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(3.w),
          child: ListView(
            children: [
              // const Icon(Icons.arrow_back, size: 50),
              SizedBox(
                width: 180.w,
                height: 50.h,
                child: ListView(
                  children: [
                    Image.asset(
                      'assets/iptv.png',
                      width: 30.w,
                      height: 7.h,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // TextButton(
                    //   onPressed: () async {
                    //     // await SpHelper.spHelperObject.deleteAllUsers();
                    //     await SpHelper.spHelperObject
                    //         .getUsersFromSharedPreferences();
                    //   },
                    //   child: const Text("get Users"),
                    // ),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            //
                            child: CustomButton(
                                'load your playList OR File  URL', () {
                              Navigator.pushNamed(
                                  context, LinkOrChannelsFolder.roudName);
                            })),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            child:
                                CustomButton('Load your data from device ', () {
                              Navigator.of(context)
                                  .pushNamed(MobileDataShow.roudName);
                            }))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: CustomButton('login with extream codes api ',
                                () {
                              Navigator.of(context)
                                  .pushNamed(XtreamCodeLoginScreen.roudName);
                            })),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: CustomButton('play single stream ', () {
                              // Navigator.of(context).pushNamed(
                              //   LoginTypeScreen.roudName,
                              // );
                            })),
                      ],
                    ),
                    SizedBox(
                      width: 120.w,
                      child: CustomButton('list users', () {
                        Navigator.of(context)
                            .pushNamed(UsersListScreen.roudName);
                      }),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding CustomButton(String text, void Function()? onPressed) {
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFFFFFFF),
              border: Border.all(color: const Color.fromARGB(255, 22, 19, 23))),
          padding: EdgeInsets.all(2.h),
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF212A3E),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
