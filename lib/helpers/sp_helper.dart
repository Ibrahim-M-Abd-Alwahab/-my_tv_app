import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_tv_app/Models/user_data.dart';
import 'package:my_tv_app/Models/users.dart';
import 'package:my_tv_app/Modules/Main/All/home.dart';
import 'package:my_tv_app/Modules/Main/login_type.dart';
import 'package:my_tv_app/Modules/loding_user_chanels_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();
  static SpHelper spHelperObject = SpHelper._();
  // delete default constructor
  // no ability to make object from this class fom outside
  static SharedPreferences? sharedPreferences;

  static initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  List<String> userKeyList = [];
  List<Users> userList = [];

  saveNewUser({
    required String username,
    required String password,
    required String ip,
    required String userUrl,
    required String status,
    required String message,
    required List<dynamic>? allowedOutputFormats,
    required int auth,
    required String expDate,
    required String isTrial,
    required String createdAt,
    required String maxConnections,
    required String activeCons,
    required String url,
    required String port,
    required String httpsPort,
    required String serverProtocol,
    required String rtmpPort,
    required String timezone,
    required String timeNow,
    required int timestampNow,
    required int flag,
  }) async {
    Map<String, dynamic> userDataMap = {
      "user_info": {
        "username": username,
        "message": message,
        "auth": auth,
        "allowed_output_formats": allowedOutputFormats,
        "password": password,
        "status": status,
        "exp_date": expDate,
        "is_trial": isTrial,
        "created_at": createdAt,
        "max_connections": maxConnections,
        "active_cons": activeCons,
        "userUrl": userUrl,
        "ip": ip,
        "flag": flag,
      },
      "server_info": {
        "url": url,
        "port": port,
        "https_port": httpsPort,
        "server_protocol": serverProtocol,
        "rtmp_port": rtmpPort,
        "timezone": timezone,
        "timestamp_now": timestampNow,
        "time_now": timeNow,
      }
    };

    List<Map<String, dynamic>> newUserList =
        await SpHelper.spHelperObject.getUsersFromSharedPreferences();
    for (var element in newUserList) {
      if (userUrl == element['userUrl']) {
        log("saveNewUser 1");
        log(element.toString());
        element['flag'] = 1;
        log(element.toString());
        (BuildContext context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LodingUserChanelsScreen(
                url: userUrl,
              ),
            ),
          );
        };
      } else {
        log("saveNewUser 2");
      }
    }
    // can't store map in SharedPreferences so i used json.encode(map) to store it in String
    String userDate = json.encode(userDataMap);
    bool success = await sharedPreferences!.setString(username, userDate);
  }

  Future<List<Map<String, dynamic>>> getUsersFromSharedPreferences() async {
    List<Map<String, dynamic>> userList = [];
    Set<String>? keys = sharedPreferences!.getKeys();
    if (keys != null) {
      for (var key in keys) {
        String? userData = sharedPreferences!.getString(key);
        if (userData != null) {
          Map<String, dynamic> userMap = json.decode(userData);
          userList.add(userMap);
          log("User data for key '$key': $userMap");
        } else {
          log("No User data");
        }
      }
      return userList;
    } else {
      log("There is No Key");
    }
    return [];
  }

  logAllUsers() async {
    Set<String>? keys = sharedPreferences!.getKeys();
    if (keys != null) {
      for (var key in keys) {
        String? userData = sharedPreferences!.getString(key);
        if (userData != null) {
          Map<String, dynamic> userMap = json.decode(userData);
          log("User data for key '$key': $userMap");
        } else {
          log("No User data");
        }
      }
    } else {
      log("There is No Key");
    }
  }

  update(String? userName) {
    Set<String>? keys = sharedPreferences!.getKeys();
    if (keys != null) {
      for (var key in keys) {
        String? userData = sharedPreferences!.getString(key);
        if (userData != null) {
          Map<String, dynamic> userMap = json.decode(userData);

          if (userMap['user_info']['username'] == userName) {
            userMap['user_info']['flag'] = 0;
            sharedPreferences!.setString(key, json.encode(userMap));
          }
          log("User data for key '$key': $userMap");
        }
      }
    }
  }

  expireSub(String? userName, BuildContext context) {
    Set<String>? keys = sharedPreferences!.getKeys();
    if (keys != null) {
      for (var key in keys) {
        String? userData = sharedPreferences!.getString(key);
        if (userData != null) {
          Map<String, dynamic> userMap = json.decode(userData);

          if (userMap['user_info']['username'] == userName) {
            userMap['user_info']['flag'] = 0;
            sharedPreferences!.setString(key, json.encode(userMap));
            log("navigate to login type screen");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LoginTypeScreen();
                },
              ),
            );
          }
          log("User data for key '$key': $userMap");
        }
      }
    }
  }

  checkUser(BuildContext context, String ip) {
    UserInfo? userInfo;
    Set<String>? keys = sharedPreferences!.getKeys();
    if (keys != null) {
      for (var key in keys) {
        String? userData = sharedPreferences!.getString(key);
        if (userData != null) {
          Map<String, dynamic> userMap = json.decode(userData);
          if (userMap['user_info']['ip'] == ip &&
              userMap['user_info']['flag'] == 1 &&
              userMap['user_info']['status'] == 'Active') {
            log("Active User: '$key'");

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  userMap['user_info']['userUrl'],
                ),
              ),
            );
            // return user;
          } else if (userMap['user_info']['ip'] != ip &&
              userMap['user_info']['flag'] == 0 &&
              userMap['user_info']['status'] == 'Expired') {
            log("Expired Subscription || no active user");

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginTypeScreen(),
              ),
            );
          }
        }
      }
    } else {
      log("There is no previous registration attempt so no data");
    }
  }

  getActiveUser(BuildContext context, String ip) {
    Set<String>? keys = sharedPreferences!.getKeys();
    if (keys != null) {
      for (var key in keys) {
        String? userData = sharedPreferences!.getString(key);
        if (userData != null) {
          Map<String, dynamic> userMap = json.decode(userData);
          if (userMap['user_info']['ip'] == ip &&
              userMap['user_info']['flag'] == 1) {
            Map<String, dynamic> userDataMap = {
              "user_info": {
                "username": userMap['user_info']['username'],
                "message": userMap['user_info']['message'],
                "auth": userMap['user_info']['auth'],
                "allowed_output_formats": userMap['user_info']
                    ['allowed_output_formats'],
                "password": userMap['user_info']['password'],
                "status": userMap['user_info']['status'],
                "exp_date": userMap['user_info']['exp_date'],
                "is_trial": userMap['user_info']['is_trial'],
                "created_at": userMap['user_info']['created_at'],
                "max_connections": userMap['user_info']['max_connections'],
                "active_cons": userMap['user_info']['active_cons'],
                "userUrl": userMap['user_info']['userUrl'],
                "ip": ip,
                "flag": userMap['user_info']['flag'],
              },
              "server_info": {
                "url": userMap['server_info']['url'],
                "port": userMap['server_info']['port'],
                "https_port": userMap['server_info']['https_port'],
                "server_protocol": userMap['server_info']['server_protocol'],
                "rtmp_port": userMap['server_info']['rtmp_port'],
                "timezone": userMap['server_info']['timezone'],
                "timestamp_now": userMap['server_info']['timestamp_now'],
                "time_now": userMap['server_info']['time_now'],
              }
            };
            UserData user = UserData.fromJson(userDataMap);
            return user;
          } else {}
        }
      }
    }
  }
  // getUserUrlByIP(String ip) {
  //   for (var element in userKeyList) {
  //     String? userData = sharedPreferences!.getString(element);
  //     if (userData != null) {
  //       Map<String, dynamic> userMap = json.decode(userData);
  //       if (userMap['ip'] == ip && userMap['flag'] == 1) {
  //         return userMap['userUrl'];
  //       }
  //     }
  //   }
  // }

  deleteAllUsers() async {
    await sharedPreferences!.clear();
    userList.clear();
    userKeyList.clear();
  }
}
