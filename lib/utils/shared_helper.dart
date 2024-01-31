import 'package:shared_preferences/shared_preferences.dart';

class ShareHelper {
  //theme
  void setTheme(bool isTheme) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setBool('theme', isTheme);
  }

  Future<bool?> getTheme() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bool? isTheme = shr.getBool('theme');
    return isTheme;
  }

  //planet Data Save
  Future<void> setBookMarkData(List<String> planet) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setStringList('data', planet);
  }

  Future<List<String>?> getBookMarkData() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    return shr.getStringList('data');
  }
}
