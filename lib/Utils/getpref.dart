import 'package:get_storage/get_storage.dart';

class GetPref{
  static GetStorage gs;
  static String fingerdata = 'fingerdata';
  static String loginData = 'loginData';
  static String userdata = 'userdata';
  static String token = '';
  static String name = '';
  static String profilepic = '';
  static String notification = '';

  static addgs(String key,value){
    gs = new GetStorage();
    gs.write(key, value);
  }
  static getgs(value){
    gs = GetStorage();
    return gs.read(value);
  }
  static getboolgs(value){
    gs = GetStorage();
    return gs.read(value) != null ? gs.read(value) : false;
  }
  static removeValues(String key) {
    gs = GetStorage();
    gs.remove(key);
  }
}