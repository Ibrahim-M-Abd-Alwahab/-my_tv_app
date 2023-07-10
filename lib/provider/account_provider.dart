import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tv_app/Models/stream.dart';
import 'package:my_tv_app/helpers/sp_helper.dart';
import '../Models/movie_data.dart';
import '../Models/serise_info.dart';
import '../Models/user_data.dart';
import '../Models/vod_categories.dart';
import '../api/data/User/add_user_api.dart';
import '../api/data/User/get_data_api.dart';
import '../utils/failure.dart';
import 'dart:io';

final accountProvider =
    ChangeNotifierProvider<AccountProvider>((ref) => AccountProvider());

class AccountProvider with ChangeNotifier {
  String userUrl = "";
  UserData? userdataModel;
  // UserInfo? userInfo;
  String? ip;
  String? dropdownvalue = "";

  Future<String> getIPAddress() async {
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var address in interface.addresses) {
          if (address.type == InternetAddressType.IPv4) {
            return address.address;
          }
        }
      }
    } catch (e) {
      throw Exception('Failed to get IP address: $e');
    }

    throw Exception('No IP address found');
  }

  selectdPlayer(String dropdownvalue) {
    this.dropdownvalue = dropdownvalue;
    return true;
  }

  Future postLogin({
    required String baseUrl,
    required String username,
    required String password,
    required String userUrl,
  }) async {
    try {
      final response = await AddUserApi(
        baseUrl: baseUrl,
        username: username,
        password: password,
      ).fetch();
      log("userUrl : $userUrl ..............this.userUrl ${this.userUrl}");

      this.userUrl = userUrl;
      log("response of AddUserApi : $response ..............");
      // userdataModel?.userInfo.username
      // setActiveOffers(storeOffers);

      userdataModel = UserData.fromJson(response);
      ip = await getIPAddress();

      try {
        String defaultMessage = response["user_info"]["message"];
        if (defaultMessage.isEmpty) {
          defaultMessage = "Default message";
        }
        await SpHelper.spHelperObject.saveNewUser(
          username: response["user_info"]["username"],
          password: response["user_info"]["password"],
          status: response["user_info"]["status"],
          expDate: response["user_info"]["exp_date"],
          isTrial: response["user_info"]["is_trial"],
          createdAt: response["user_info"]["created_at"],
          maxConnections: response["user_info"]["max_connections"],
          activeCons: response["user_info"]["active_cons"],
          allowedOutputFormats: response["user_info"]["allowed_output_formats"],
          auth: response["user_info"]["auth"],
          message: defaultMessage,
          url: response["server_info"]["url"],
          port: response["server_info"]["port"],
          httpsPort: response["server_info"]["https_port"],
          serverProtocol: response["server_info"]["server_protocol"],
          rtmpPort: response["server_info"]["rtmp_port"],
          timezone: response["server_info"]["timezone"],
          timeNow: response["server_info"]["time_now"],
          timestampNow: response["server_info"]["timestamp_now"],
          ip: ip!,
          flag: 1,
          userUrl: userUrl,
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }

      return true;
    } on Failure {
      return "Something Wrong";
    }
  }

  List<VodCategories> _vodCategories = [];
  //! create get method for the data object
  List<VodCategories>? get getVodCategoriesList => _vodCategories;
  void setAllMovieList(List<VodCategories> vod) {
    _vodCategories = vod;
    notifyListeners();
  }

  List<StreamingModel> _streamingModel = [];
  //! create get method for the data object
  List<StreamingModel>? get getStreamingModelList => _streamingModel;
  void setStreamingModel(List<StreamingModel> vod) {
    _streamingModel = vod;
    notifyListeners();
  }

  //------
  List<AllMovie> _allMovie = [];
  //! create get method for the data object
  List<AllMovie>? get getAllMovieist => _allMovie;
  void setMovieList(List<AllMovie> vod) {
    _allMovie = vod;
    notifyListeners();
  }

  //------
  List<AllMovie> _seriesList = [];
  //! create get method for the data object
  List<AllMovie>? get getSeriesList => _seriesList;
  void setSeriesList(List<AllMovie> vod) {
    _seriesList = vod;
    notifyListeners();
  }

  //------
  List<AllMovie> _seriesByCateIdList = [];
  //! create get method for the data object
  List<AllMovie>? get getSeriesCateIdList => _seriesByCateIdList;
  void setSeriesByCateIdList(List<AllMovie> vod) {
    _seriesByCateIdList = vod;
    notifyListeners();
  }

  //------
  SerisInfoModel _serisInfoModel = SerisInfoModel();
  //! create get method for the data object
  SerisInfoModel? get getSerisInfoModel => _serisInfoModel;
  void setSerisInfoModel(SerisInfoModel vod) {
    _serisInfoModel = vod;
    notifyListeners();
  }

  Future getUserDataByAction({
    required String url,
    required String action,
  }) async {
    try {
      log("#####$url####");
      final response = await GetUserDataByAction(url: url).fetch();

      //userUrl = userUrl;
      log("response $response");
      // response as list dynamic to list  of VodCategories
      var data = response as List<dynamic>;
      List<VodCategories> vodCategories =
          data.map((e) => VodCategories.fromJson(e)).toList();

      setAllMovieList(vodCategories);
      // userdataModel?.userInfo.username
      // setActiveOffers(storeOffers);
      // userdataModel = UserData.fromJson(response);
      return true;
    } on Failure {
      return false;
    }
  }

  Future getStreamDataByAction({
    required String url,
    required String action,
  }) async {
    try {
      final response = await GetUserDataByAction(url: url).fetch();

      //userUrl = userUrl;
      log("response $response");
      // response as list dynamic to list  of VodCategories
      var data = response as List<dynamic>;
      List<StreamingModel> vodCategories =
          data.map((e) => StreamingModel.fromJson(e)).toList();

      setStreamingModel(vodCategories);
      // userdataModel?.userInfo.username
      // setActiveOffers(storeOffers);
      // userdataModel = UserData.fromJson(response);
      return true;
    } on Failure {
      return false;
    }
  }

  Future getMoviesDataByAction(
      {required String url, required String action}) async {
    try {
      final response = await GetUserDataByAction(url: url).fetch();

      //userUrl = userUrl;
      log("response $response");
      // response as list dynamic to list  of VodCategories
      var data = response as List<dynamic>;
      List<VodCategories> vodCategories =
          data.map((e) => VodCategories.fromJson(e)).toList();

      setAllMovieList(vodCategories);
      // userdataModel?.userInfo.username
      // setActiveOffers(storeOffers);
      // userdataModel = UserData.fromJson(response);
      return true;
    } on Failure {
      return false;
    }
  }

  Future getSiresDataByAction(
      {required String url, required String action}) async {
    try {
      final response = await GetUserDataByAction(url: url).fetch();

      //userUrl = userUrl;
      log("response $response");
      // response as list dynamic to list  of VodCategories
      var data = response as List<dynamic>;
      List<AllMovie> vodCategories =
          data.map((e) => AllMovie.fromJson(e)).toList();

      // userdataModel?.userInfo.username
      setSeriesList(vodCategories);
      // userdataModel = UserData.fromJson(response);
      return true;
    } on Failure {
      return false;
    }
  }

  Future getSiresDataByCateId(
      {required String url, required String action}) async {
    try {
      final response = await GetUserDataByAction(url: url).fetch();

      //userUrl = userUrl;
      log("response $response");
      // response as list dynamic to list  of VodCategories
      var data = response as List<dynamic>;
      List<AllMovie> vodCategories =
          data.map((e) => AllMovie.fromJson(e)).toList();

      // userdataModel?.userInfo.username
      setSeriesByCateIdList(vodCategories);
      // userdataModel = UserData.fromJson(response);
      return true;
    } on Failure {
      return false;
    }
  }

  Future getUserDataByCateg(
      {required String url, required String action}) async {
    try {
      final response = await GetUserDataByAction(url: url).fetch();

      //userUrl = userUrl;
      log("getUserDataByCateg ==> response ==> $response");
      // response as list dynamic to list  of VodCategories
      var data = response as List<dynamic>;
      List<AllMovie> vodCategories =
          data.map((e) => AllMovie.fromJson(e)).toList();

      setMovieList(vodCategories);
      // userdataModel?.userInfo.username
      // setActiveOffers(storeOffers);
      // userdataModel = UserData.fromJson(response);
      return true;
    } on Failure {
      return false;
    }
  }

  Future getSeriesDataById(
      {required String url, required String action}) async {
    try {
      final response = await GetUserDataByAction(url: url).fetch();

      //userUrl = userUrl;
      log("response $response");
      // response as list dynamic to list  of VodCategories
      // List<AllMovie> vodCategories =
      //     data.map((e) => AllMovie.fromJson(e)).toList();
      setSerisInfoModel(SerisInfoModel.fromJson(response));
      // setAllSeriesById(vodCategories);
      // userdataModel?.userInfo.username
      // setActiveOffers(storeOffers);
      // userdataModel = UserData.fromJson(response);
      return true;
    } on Failure {
      return false;
    }
  }

  void iconOnTap({
    required BuildContext context,
    required String text,
    required String content,
    required String done,
    required Function()? onPressed,
    required bool? warning,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(text, textAlign: TextAlign.start),
          content: Text(content, textAlign: TextAlign.start),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey,
                  ),
                  child: TextButton(
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: warning == true
                        ? const Color(0xFFB5525C)
                        : const Color(0xff73AC87),
                  ),
                  child: TextButton(
                    onPressed: onPressed,
                    child: Text(
                      done,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
