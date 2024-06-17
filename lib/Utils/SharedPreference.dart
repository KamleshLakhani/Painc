import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences prefs;
  static String deviceToken = 'deviceToken';
  static String loginData = 'loginData';
  static String justInstalled = 'justInstalled';
  static String fingerdata = 'fingerdata';
  static String notification = 'notification';

  static addStringToSF(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  static addBoolToSF(String key, bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
  static addintToSF(String key, int value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<String> getStringValuesSF(String key) async{
    prefs = await SharedPreferences.getInstance();
    String getString = prefs.getString(key);
    return (getString != null) ? getString : '';
  }
  static Future<int> getintValuesSF(String key) async {
    prefs = await SharedPreferences.getInstance();
    int getInt = prefs.getInt(key);
    return (getInt != null) ? getInt : '';
  }
  static Future<bool> getBoolValuesSF(String key) async {
    prefs = await SharedPreferences.getInstance();
    bool getBool = prefs.getBool(key);
    return (getBool != null) ? getBool : false;
  }
  static Future removeValues(String key) async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future containsKey(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
