import 'package:shared_preferences/shared_preferences.dart';

class CommonSharedPreferences {
  static late SharedPreferences prefs;

  static String searchList = "search_list";

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setSearchList(List<String> searchArray) async {
    return await prefs.setStringList(searchList, searchArray);
  }

  static List<String> getSearchList() {
    return prefs.getStringList(searchList) ?? [];
  }
}
