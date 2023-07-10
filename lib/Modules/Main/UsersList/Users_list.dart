import 'package:flutter/material.dart';
import 'package:my_tv_app/helpers/sp_helper.dart';
import 'package:sizer/sizer.dart';

class UsersListScreen extends StatefulWidget {
  static const roudName = "/UsersListScreen";

  const UsersListScreen({Key? key}) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  List<Map<String, dynamic>>? newUserList;

  @override
  void initState() {
    super.initState();
    fetchUserList();
  }

  Future<void> fetchUserList() async {
    newUserList = await SpHelper.spHelperObject.getUsersFromSharedPreferences();
    setState(() {}); // Trigger a rebuild to update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff9BA4B5),
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: const Color(0xFF394867),
          leading: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 15.sp,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 20),
              child: Text(
                'All User',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xffF1F6F9),
                ),
              ),
            ),
          ],
          elevation: 0,
        ),
        body: newUserList!.isEmpty
            ? const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    color: Color(0xff1746A2),
                  ),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(2.h),
                itemCount: newUserList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10.h,
                        width: 165.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: const Color(0xffF1F6F9)),
                            color: const Color(0xff394867)),
                        child: Padding(
                          padding: EdgeInsets.all(1.h),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return HomeChannelsScreen('');
                              //       // return HomeScreen(userList[index].userUrl!);
                              //     },
                              //   ),
                              // );
                            },
                            child: ListTile(
                              title: Text(
                                '${newUserList![index]['user_info']['username']}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                '${newUserList![index]['user_info']['userUrl']}',
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.start,
                              ),
                              leading: Image.asset(
                                'assets/userProfile.png',
                                height: 10.w,
                                fit: BoxFit.fill,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      )
                    ],
                  );
                }));
  }
}
