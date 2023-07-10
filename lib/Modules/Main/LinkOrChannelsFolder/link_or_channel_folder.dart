import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:group_radio_button/group_radio_button.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../helpers/database_helper.dart';
import '../../../provider/account_provider.dart';
import '../../loding_user_chanels_screen.dart';
import '../UsersList/Users_list.dart';
import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'dart:async';

String _verticalGroupValue = "file";

List<String> _status = [
  "file",
  "m3u link",
];

class LinkOrChannelsFolder extends ConsumerStatefulWidget {
  static const roudName = "/LinkOrChannelsFolder";

  const LinkOrChannelsFolder({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LinkOrChannelsFolderState createState() => _LinkOrChannelsFolderState();
}

class _LinkOrChannelsFolderState extends ConsumerState<LinkOrChannelsFolder> {
  TextEditingController nameController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  var username = 'http://7a7a-m3u.live:8080';
  var password = 'abuelabed';
  var baseUrl = '0599509998';
  String url = '';

  Future _getContentData({userUrl}) async {
    //! get access to the DataProvider Class
    final dataProv = ref.read(accountProvider);

    //! call the getDataRequset method to get the data
    // return await dataProv.postLogin(
    // baseUrl: baseUrl,
    // username: dataProv.userdataModel?.userInfo?.username ?? "",
    // password: dataProv.userdataModel?.userInfo?.password ?? "");

    return await dataProv.postLogin(
      baseUrl: baseUrl,
      username: username,
      password: password,
      userUrl: userUrl,
    );
  }

  List<Map<String, dynamic>> myData = [];
  final formKey = GlobalKey<FormState>();

  void _refreshData() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      myData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  // void showMyForm(int? id) async {
  //   // id == null -> create new item
  //   // id != null -> update an existing item
  //   if (id != null) {
  //     final existingData = myData.firstWhere((element) => element['id'] == id);
  //     nameController.text = existingData['name'];
  //     linkController.text = existingData['link'];
  //   } else {
  //     nameController.text = "";
  //     linkController.text = "";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
        backgroundColor: const Color(0xFF394867),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 2.h),
              Image.asset(
                'assets/iptv.png',
                height: 5.h,
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: Container(
                  color:
                      const Color.fromARGB(255, 208, 208, 208).withOpacity(0.4),
                  padding: const EdgeInsets.all(10),
                  width: 200.w,
                  height: 30.h,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      // it need form key and store user date in local db
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: TextField(
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            hintText: 'enter any name ',
                            hintStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                          top: 6.w,
                        ),
                        child: Text(
                          ' app data ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w),
                        child: Column(
                          children: [
                            RadioGroup<String>.builder(
                              groupValue: _verticalGroupValue,
                              onChanged: (value) => setState(() {
                                _verticalGroupValue = value!;
                              }),
                              activeColor:
                                  const Color.fromARGB(255, 35, 24, 37),
                              items: _status,
                              itemBuilder: (item) => RadioButtonBuilder(item),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 0.5.h),
                        child: Container(
                          child: _verticalGroupValue == 'm3u link'
                              ? TextField(
                                  controller: linkController,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    hintText: ' Enter the link ',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 10.sp),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    var path = await pickImag();
                                    readFileAsLines(path ?? "");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(2.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      ' download file',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: 90.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xFFFF9800)),
                                child: TextButton(
                                  onPressed: () async {
                                    // if (formKey.currentState!.validate()) {
                                    //   // if (id == null) {
                                    //   //   await addItem();
                                    //   // }

                                    //   // Clear the text fields
                                    //   setState(() {
                                    //     nameController.text = '';
                                    //     linkController.text = '';
                                    //   });
                                    // }

                                    // http://7a7a-m3u.live:8080/get.php?username=ahjaber&password=530520&type=m3u&output=ts
                                    if (linkController.text.contains('?') &&
                                        linkController.text
                                            .contains('username=') &&
                                        linkController.text
                                            .contains('password=')) {
                                      var uri = Uri.parse(linkController.text);

                                      username = uri.queryParameters['username']
                                          .toString();
                                      password = uri.queryParameters['password']
                                          .toString();

                                      baseUrl = uri.origin;
                                      url =
                                          '$baseUrl/player_api.php?username=$username&password=$password';

                                      _getContentData(userUrl: url)
                                          .then((value) {
                                        if (value == true) {
                                          if (ref
                                                  .watch(accountProvider)
                                                  .userdataModel
                                                  ?.userInfo
                                                  ?.auth ==
                                              1) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LodingUserChanelsScreen(
                                                        url: url,
                                                      )),
                                            );
                                          }
                                        }
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'add user ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                )),
                            Container(
                                width: 90.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xFF1746A2)),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(UsersListScreen.roudName);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      '  user list',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Future<String?> pickImag() async {
// Open the file picker
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: [
      'm3u',
    ],
  );

// If a file was picked, read its contents
  if (result != null) {
    List<PlatformFile> files = result.files;
    // Read the first file
    File file = File(files.first.path ?? "");
    // Read the file contents
    String contents = await file.readAsString();
    // Do something with the contents

    return file.path;
  }
  return null;
}

List<String> readFileAsLines(String path) {
  List<Map<String, String>> titlesAndLinks = [];
  // Open the file
  File file = File(path);

  // Read the file as a single string
  String contents = file.readAsStringSync();

  // Split the string into individual lines
  List<String> lines = LineSplitter.split(contents).toList();
  // Iterate over the lines
  for (int i = 0; i < lines.length; i++) {
    // Print the line number and the line
    // print('${i + 1}: ${lines[i]}');ر
    if (lines[i].contains('EXTINF')) {
      titlesAndLinks.add({
        'title': lines[i].split(',')[1],
        'link': lines[i + 1],
      });
    }
  }

  log("titlesAndLinks ${titlesAndLinks.length}");
  log("titlesAndLinks ${titlesAndLinks[0]['title']}");
  log("titlesAndLinks ${titlesAndLinks[0]['link']}");
  log("lines ${lines.length}");

  return lines;
}
