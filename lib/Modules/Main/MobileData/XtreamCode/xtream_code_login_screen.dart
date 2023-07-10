import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../../../../provider/account_provider.dart';
import '../../../loding_user_chanels_screen.dart';
import '../../UsersList/Users_list.dart';

class XtreamCodeLoginScreen extends ConsumerStatefulWidget {
  static const roudName = "/XtreamCodeLoginScreen";

  const XtreamCodeLoginScreen();

  @override
  _XtreamCodeLoginScreenState createState() => _XtreamCodeLoginScreenState();
}

class _XtreamCodeLoginScreenState extends ConsumerState<XtreamCodeLoginScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final serverController = TextEditingController();
  var username = 'http://7a7a-m3u.live:8080';
  var password = 'abuelabed';
  var baseUrl = '0599509998';
  String url = '';
  late Future _fetchedData;

  Future _getContentData({userUrl}) async {
    AccountProvider dataProv = ref.read(accountProvider);

    return await dataProv.postLogin(
      baseUrl: baseUrl,
      username: username,
      password: password,
      userUrl: userUrl,
    );
  }

  @override
  void initState() {
    _fetchedData = _getContentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accountProviderObject = AccountProvider();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF394867),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 3.h),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Center(
                  child: Image.asset(
                'assets/iptv.png',
                width: 25.w,
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Text(
                  'Enter Your Subscription Data',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: const Color(0xffF1F6F9),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0x739BA4B5)),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Color(0xffF1F6F9)),
                    controller: nameController,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      hintText: '  user name ',
                      hintStyle: TextStyle(
                        color: Color(0xff9BA4B5),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0x739BA4B5)),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Color(0xffF1F6F9)),
                    controller: passwordController,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      hintText: ' password  ',
                      hintStyle: TextStyle(
                        color: Color(0xff9BA4B5),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0x739BA4B5)),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Color(0xffF1F6F9)),
                    controller: serverController,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      hintText: 'xtreem code :http://url_here.com:port',
                      hintStyle: TextStyle(
                        color: Color(0xff9BA4B5),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Container(
                        width: 85.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green),
                        child: TextButton(
                          onPressed: () {
                            if (nameController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                serverController.text.isNotEmpty) {
                              username = nameController.text;
                              password = passwordController.text;
                              var uri = Uri.parse(serverController.text);
                              baseUrl = uri.origin;

                              url =
                                  '$baseUrl/player_api.php?username=$username&password=$password';

                              _getContentData(userUrl: url).then((value) {
                                if (value == true) {
                                  if (ref
                                              .watch(accountProvider)
                                              .userdataModel
                                              ?.userInfo
                                              ?.auth ==
                                          1 &&
                                      ref
                                              .watch(accountProvider)
                                              .userdataModel
                                              ?.userInfo
                                              ?.status ==
                                          'Active') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LodingUserChanelsScreen(
                                          url: url,
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          width: 300,
                                          content: Text(
                                            "Your subscription has expired. Please get a new subscription.",
                                            textAlign: TextAlign.center,
                                          )),
                                    );
                                  }
                                } else {}
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  width: 300,
                                  content: Text(
                                    'You need to fill in the fields first.',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              ' add user ',
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
                            color: Colors.orange),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(UsersListScreen.roudName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              ' users screen ',
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
      ),
    );
  }
}
