import 'package:flutter/material.dart';
import 'package:galaxy_planets/screen/home/model/home_model.dart';
import 'package:galaxy_planets/utils/json_helper.dart';

import '../../../utils/shared_helper.dart';

class HomeProvider with ChangeNotifier {
  List<HomeModel> planetList = [];
  int? isIndex;
  bool ani=false;

  //change index
  void changeIndex(int index) {
    isIndex = index;
    notifyListeners();
  }

  void animation(bool change)
  {
    ani=change;
    notifyListeners();
  }

  //get json data
  Future<void> getPlanetData() async {
    JsonHelper jsonHelper = JsonHelper();
    List<HomeModel> l1 = await jsonHelper.jsonToModel();
    planetList = l1;
    notifyListeners();
  }

  //bookmark
  List<String>? bookMarkList = [];

  void getBookMarkData() async {
    ShareHelper shr = ShareHelper();
    List<String>? l1 = await shr.getBookMarkData();
    if (l1 != null) {
      bookMarkList = l1;
    }
    notifyListeners();
  }

  void addBookMarkData() {
    ShareHelper shr = ShareHelper();
    bookMarkList!.add(planetList[isIndex!].name!);
    shr.setBookMarkData(bookMarkList!);
    getBookMarkData();
    notifyListeners();
  }

  void removeBookMarkData() {
    ShareHelper shr = ShareHelper();
    bookMarkList!.remove(planetList[isIndex!].name);
    shr.setBookMarkData(bookMarkList!);
    getBookMarkData();
    notifyListeners();
  }
}
