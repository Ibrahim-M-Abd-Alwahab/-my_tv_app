import 'dart:developer';
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tv_app/Models/movie_data.dart';
import '../api/data/get_data_api.dart';
import '../utils/failure.dart';

final dataProvider =
    ChangeNotifierProvider<DataProvider>((ref) => DataProvider());

class DataProvider extends ChangeNotifier {
  //! create the data object
  AllMovie? _allMovie = AllMovie();
//! create get method for the data object
  AllMovie? get getDataList => _allMovie;
  void setAllMovieList(AllMovie allMovie) {
    _allMovie = allMovie;
    notifyListeners();
  }

  Future getDataRequset({page}) async {
    //! we create this object to set new data to the data object
    AllMovie? allMovie = AllMovie();

    try {
      //! here we call the api and get the data using the Fetch method
      final response = await GetDataAPi().fetch();
      //! use FormJson method to convert the data to the data object
      allMovie = AllMovie.fromJson(response);
      log("response $response");
      //! set the new data to the data object
      setAllMovieList(allMovie);

      return allMovie;
    } on Failure catch (f) {
      log("message $f");
      return f;
    }
  }

  // Future postDataRequset({required String title, required String email}) async {
  //   //! we create this object to set new data to the data object
  //   DataModel? contentList = DataModel();

  //   try {
  //     //! here we call the api and get the data using the Fetch method
  //     final response = await AddUserApi(
  //       title: title,
  //       email: email,
  //     ).fetch();
  //     //! use FormJson method to convert the data to the data object
  //     contentList = DataModel.fromJson(response);
  //     log("response $response");
  //     //! set the new data to the data object
  //     setDataList(contentList);

  //     return contentList;
  //   } on Failure catch (f) {
  //     return f;
  //   }
  // }


}
