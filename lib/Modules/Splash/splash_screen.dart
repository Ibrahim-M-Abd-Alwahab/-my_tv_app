import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:my_tv_app/helpers/sp_helper.dart';
import 'package:my_tv_app/provider/account_provider.dart';
import 'package:sizer/sizer.dart';
import '../Main/login_type.dart';

class SplashScreen extends StatefulWidget {
  static const roudName = "/SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final accountProvider = AccountProvider();

  @override
  void initState() {
    super.initState();
    final BuildContext contextRef = context; // Store the context reference
    Future.delayed(const Duration(seconds: 5), () async {
      String ip = await accountProvider.getIPAddress();
      // ignore: use_build_context_synchronously
      SpHelper.spHelperObject.checkUser(contextRef, ip);
      // SpHelper.spHelperObject.expireSub(username!, contextRef);
    });

    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          LoginTypeScreen.roudName,
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Image.asset(
          'assets/splashsc.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      )),
    );
  }
}
