import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tv_app/Models/user_data.dart';
import 'package:my_tv_app/Modules/Channels/home_chanels_screen.dart';
import 'package:my_tv_app/Modules/Main/All/Settings/settings_screen.dart';
import 'package:my_tv_app/Modules/Main/All/multyScreen/multy_screen.dart';
import 'package:my_tv_app/Modules/Main/All/user_data_screen.dart';
import 'package:my_tv_app/Modules/Main/login_type.dart';
import 'package:my_tv_app/helpers/sp_helper.dart';
import 'package:my_tv_app/provider/account_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Wedgits/CustomContainerRadious.dart';
import 'notification_screen.dart';

class HomeScreen extends ConsumerWidget {
  String url;

  static const roudName = "/HomeScreen";

  HomeScreen(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    final accountProviderObject = AccountProvider();
    UserData? userData;

    // String extractUsernameFromLink() {
    //   int startIndex = url.indexOf("username=") + "username=".length;
    //   int endIndex = url.indexOf("&", startIndex);
    //   String username = url.substring(startIndex, endIndex);
    //   log(username); // Output: ahjaber
    //   return username;
    // }

    // String? username = extractUsernameFromLink();
    // Future.delayed(Duration.zero, () async {
    //   String ip = await accountProviderObject.getIPAddress();
    //   // ignore: use_build_context_synchronously
    //   UserData? currentUserData = ref.watch(accountProvider).userdataModel;
    //   if (currentUserData == null) {
    //     log("currentUserData null");
    //     // ignore: use_build_context_synchronously
    //     userData = await SpHelper.spHelperObject.getActiveUser(context, ip);
    //   } else {
    //     log("currentUserData exist");
    //     userData = currentUserData;
    //   }
    //   log("userData ${userData!.userInfo!.username!}");
    //   username = userData!.userInfo!.username;
    //   log("username: $username");
    // });
    String username = 'Unknown';

    // ignore: no_leading_underscores_for_local_identifiers
    Future<UserData?> _fetchUsername() async {
      String? ip = await accountProviderObject.getIPAddress();
      UserData? currentUserData = ref.watch(accountProvider).userdataModel;
      if (currentUserData == null) {
        log("currentUserData null");

        // ignore: use_build_context_synchronously
        userData = await SpHelper.spHelperObject.getActiveUser(context, ip);
      } else {
        log("currentUserData exist");

        userData = currentUserData;
      }
      username = userData?.userInfo?.username ?? 'Unknown';
      return userData;
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
    ]);
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: SafeArea(
          child: Scaffold(
              backgroundColor: const Color(0xFF394867),
              body: ListView(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: const Icon(
                                  Icons.person,
                                  size: 26,
                                  color: Color(0xff9BA4B5),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserDataScreen(
                                        userData: userData,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // SizedBox(width: 1.w),
                              // GestureDetector(
                              //   child: const Icon(
                              //     Icons.people,
                              //     size: 26,
                              //     color: Color(0xff9BA4B5),
                              //   ),
                              //   onTap: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             const UsersListScreen(),
                              //       ),
                              //     );
                              //   },
                              // ),
                              SizedBox(width: 1.w),
                              GestureDetector(
                                child: const Icon(
                                  Icons.notifications,
                                  size: 26,
                                  color: Color(0xff9BA4B5),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationScreen(userData!),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 1.w),
                              GestureDetector(
                                child: const Icon(
                                  Icons.lock,
                                  size: 26,
                                  color: Color(0xff9BA4B5),
                                ),
                                onTap: () {
                                  accountProviderObject.iconOnTap(
                                    context: context,
                                    warning: false,
                                    text: 'Louck',
                                    content:
                                        'You need to purchase a Premium subscription to take advantage of these features',
                                    done: "Subscription",
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  );
                                },
                              ),
                              // GestureDetector(
                              //   child: const Icon(
                              //     Icons.search,
                              //     size: 26,
                              //     color: Color(0xff9BA4B5),
                              //   ),
                              //   onTap: () {
                              //     iconOnTap(context, 'searsh');
                              //   },
                              // ),
                              SizedBox(width: 1.w),

                              GestureDetector(
                                child: const Icon(
                                  Icons.logout,
                                  size: 26,
                                  color: Color(0xff9BA4B5),
                                ),
                                onTap: () async {
                                  accountProviderObject.iconOnTap(
                                    context: context,
                                    warning: true,
                                    text: 'Logout',
                                    content: 'Are you sure you want to logout?',
                                    done: "OK",
                                    onPressed: () async {
                                      await SpHelper.spHelperObject
                                          .update(userData!.userInfo!.username);
                                      // SpHelper.spHelperObject.deleteAllUsers();
                                      //  ignore: use_build_context_synchronously
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginTypeScreen(),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              // IconButton(
                              //   onPressed: () async {
                              //     await SpHelper.spHelperObject.logAllUsers();
                              //   },
                              //   icon: const Icon(
                              //     Icons.data_array,
                              //     size: 26,
                              //     color: Colors.red,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          width: 30.w,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Home Page',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.sp,
                              color: const Color(0xffF1F6F9),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/iptv.png',
                          width: 20.w,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeChannelsScreen(
                                  "get_live_categories", url),
                            ),
                          );
                        },
                        child: CustomContainerRadious(
                          width: 70.w,
                          height: 28.h,
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff36CD9C),
                              Color(0xff3F3DE9),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/television.png',
                                  width: 120,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(
                                  height: 1.w,
                                ),
                                Text(
                                  ' Live TV',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 130.w,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .pushNamed(HomeChannelsScreen.roudName);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HomeChannelsScreen(
                                                "get_vod_categories", url),
                                      ),
                                    );
                                  },
                                  child: CustomContainerRadious(
                                    width: 62.w,
                                    height: 22.h,
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xff9942B7),
                                        Color(0xff5C8AD7),
                                      ],
                                    ),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/movie.png',
                                          width: 100,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          height: 1.w,
                                        ),
                                        Text(
                                          ' Movies ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .pushNamed(HomeChannelsScreen.roudName);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomeChannelsScreen(
                                                  "get_series_categories",
                                                  url)),
                                    );
                                  },
                                  child: CustomContainerRadious(
                                      width: 62.w,
                                      height: 22.h,
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xffC83349),
                                          Color(0xffE08B3A),
                                        ],
                                      ),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/series.png',
                                            width: 100,
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(
                                            height: 1.w,
                                          ),
                                          Text(
                                            'Series ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ))),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .pushNamed(SettingsScreen.roudName);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SettingsScreen(userData: userData),
                                      ),
                                    );
                                  },
                                  child: CustomContainerRadious(
                                    color: const Color(0xff73AC87),
                                    child: const Center(
                                      child: Text(
                                        'Settings',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(MultyScreen.roudName);
                                  },
                                  child: CustomContainerRadious(
                                    color: const Color(0xff73AC87),
                                    child: const Center(
                                      child: Text(
                                        'Multi Screen ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .pushNamed(SettingsScreen.roudName);
                                  },
                                  child: CustomContainerRadious(
                                    color: const Color(0xff73AC87),
                                    child: const Center(
                                        child: Text(
                                      'Live broadcast with TV program guide',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(right: 4.w, top: 35),
                    child: FutureBuilder<UserData?>(
                      future: _fetchUsername(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While the future is loading, you can display a loading indicator.
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // If there's an error in fetching the username, you can display an error message.
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // If the future completed successfully, you can display the username.
                          final username =
                              snapshot.data?.userInfo?.username ?? 'Unknown';
                          return Text(
                            'Logged in: $username',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xff9BA4B5),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              )),
        ));
  }
}
