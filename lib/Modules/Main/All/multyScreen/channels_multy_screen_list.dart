import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'all_channels.dart';
import 'favoret.dart';

class ChannelsMultyScreen extends StatefulWidget {
  static const roudName = "/ChannelsMultyScreen";

  const ChannelsMultyScreen();

  @override
  State<ChannelsMultyScreen> createState() => _ChannelsMultyScreenState();
}

class _ChannelsMultyScreenState extends State<ChannelsMultyScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // title: Text('Flutter Tabs Demo'),
          bottom: TabBar(
            tabs: [Tab(text: "المفضلة"), Tab(text: " الكل")],
          ),
        ),
        body: TabBarView(
          children: [
            FavorateChannelScreen(),
            AllChannelScreen(),
          ],
        ),
      ),
    );
  }
}
