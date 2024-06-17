import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/SharedPreference.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:painc/Utils/getpref.dart';
//final datacount = GetStorage();
class BioController extends GetxController{
  //bool dt = datacount.read('fngr');
  bool dt = GetPref.getboolgs(GetPref.fingerdata);
  RxBool ison = false.obs;
  final LocalAuthentication localAuthentication = LocalAuthentication();
  void toggleSwitch(val) async{
      if(val == true){
        bool isAuthenticated = await Authentication.authenticateWithBiometrics();
        if (isAuthenticated) {
          GetPref.addgs(GetPref.fingerdata, true);
          dt = !dt;
          update();
          Constant.bioforios2 = false;
          Future.delayed(Duration(seconds: 2),(){
            Constant.bioforios = true;
          });
          // ison.toggle();
          ///datacount.write("fngr", true);
          // print('##### ${datacount.read("fngr")}');
          // print('@@@@@@@@ $dt');
          //SharedPreference.addBoolToSF(SharedPreference.fingerdata,true);
          // bool data = await SharedPreference.getBoolValuesSF(SharedPreference.fingerdata);
          // print('###### $data');
          // print('##### ${datacount.read("fngr")}');
        }
        else {
          print('not authenticated');
        }
      }
      else{
        ///datacount.write("fngr", false);
        GetPref.addgs(GetPref.fingerdata, false);
        dt = !dt;
        update();
        // print('##### ${datacount.read("fngr")}');
        // print('@@@@@@@@ $dt');
        //SharedPreference.addBoolToSF(SharedPreference.fingerdata,false);
        // bool data = await SharedPreference.getBoolValuesSF(SharedPreference.fingerdata);
        // print('******* $data');
        // ison.toggle();
      }
}
}
class Authentication {
  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    bool isAuthenticated = false;
    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticateWithBiometrics(
        localizedReason: 'Please complete the biometrics to proceed.',
      );
    }else{
      Utils.toast('Biometrics Error', 'Please setup biometrics from your settings', Utils.red.withOpacity(.4));
      print('not found');
    }
    return isAuthenticated;
  }
}