import 'dart:convert';

import 'package:flutter/services.dart';

import '../screen/home/model/home_model.dart';

class JsonHelper{
  Future<List<HomeModel>> jsonToModel()
  async {
    var planetString = await rootBundle.loadString("assets/json/galaxy.json");
    List planet= jsonDecode(planetString);
    List<HomeModel> planetList = planet.map((e) => HomeModel.mapToModel(e)).toList();
    return planetList;
  }
}