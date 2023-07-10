import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_tv_app/Modules/Main/All/home.dart';

class LodingUserChanelsScreen extends StatefulWidget {
  String url;

  static const roudName = "/LodingUserChanelsScreen";

  LodingUserChanelsScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<LodingUserChanelsScreen> createState() => _LodingUserChanelsScreen();
}

class _LodingUserChanelsScreen extends State<LodingUserChanelsScreen> {
  @override
  void initState() {
    super.initState();
    log(widget.url);
    Timer(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            widget.url,
            
          ),
        ),
      ),
    );

    // Navigator.of(context).pushNamedAndRemoveUntil(context,HomeScreen.roudName));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Image.asset(
          'assets/load.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      )),
    );
  }
}
