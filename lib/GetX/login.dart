import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:painc/ApiClass/GetGDPR.dart';
import 'package:painc/ApiClass/update.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/SharedPreference.dart';
import 'package:painc/Utils/routes.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/loader.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/screens/CreateNewPasswordActivity.dart';
import 'package:painc/screens/Dashboard.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/ApiClass/login.dart';
import 'package:http/http.dart' as http;
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/getpref.dart';
import 'package:painc/screens/ForgotPasswordActivity.dart';
import 'biometricenable.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginform = GlobalKey<FormState>(debugLabel: 'loginform');
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool fgr = GetPref.getboolgs(GetPref.fingerdata);
  final devicedata = GetStorage();
  final LocalAuthentication localAuthentication = LocalAuthentication();
  @override
  void onInit() async {
    getToken();
    if (fgr == true) {
      bool isAuthenticated = await Authentication.authenticateWithBiometrics();
      if (isAuthenticated) {
        Get.offAll(()=>Dashboard());
      } else {
        print('not Authenticated');
      }
    }
    super.onInit();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Future loginvalidation(context) async {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
     String deviceId = await _getId();
     String firebase_token = await getToken();
    print('KJLKJLKJL ${deviceId}');
    if (loginform.currentState.validate()) {
      showLoadingDialog(context: context);
      print('DONE');
      print(Constant.token);
      var jsonData = {
        'email': usernameController.text.trim(),
        'password': passwordController.text.trim(),
        'device_id' : deviceId.trim(),
        'firebase_token': firebase_token.trim(),
      };
      print(jsonData);
      http.Response response =
          await ResponseClass.callPostApi(jsonData, ApiSheet.login);
      String responceString = response.body;
      //print(responceString);
      LoginModel loginmodel = LoginModel.fromJson(jsonDecode(responceString));
      if (loginmodel.status) {
        hideLoadingDialog(context: context);
        GetPref.addgs(GetPref.loginData, responceString);
        String data = GetPref.getgs(GetPref.loginData);
        loginmodel = LoginModel.fromJson(json.decode(data));
        var dataa = GetPref.getgs(GetPref.loginData);
        //print('GTGTGTGTGTGG ${loginmodel.data.user.device_id}');
        // SharedPreference.addStringToSF(SharedPreference.loginData, responceString);
        //String data = await SharedPreference.getStringValuesSF(SharedPreference.loginData);
        // // LoginModel login = LoginModel.fromJson(json.decode(data));
        Constant.token = loginmodel.token;
        Constant.name = '${loginmodel.user.firstName} ${loginmodel.user.surname}';
        Constant.profilepic = loginmodel.user.profileImage;
        Constant.email = loginmodel.user.email;
        print(Constant.token);
        SharedPreference.addStringToSF(SharedPreference.deviceToken, deviceId);
        //GetPref.addgs(GetPref.token, Constant.token);
        print('TOKEN TOKEN' + Constant.token);
        clear();
        Constant.freshuser = loginmodel.user.fresh_login;
        print('LLLLLLL ${loginmodel.user.fresh_login}');
        Get.offAllNamed(Routes.dashboard);
      }
      else if(response.statusCode == 200 && loginmodel.status == false){
        hideLoadingDialog(context: context);
        Constant.email = usernameController.text.trim();
        showDialog(context: context, builder: (context) =>
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: screenwidth,
                    padding: EdgeInsets.only(top: screenheight*.035, left: screenwidth*.03, right:  screenwidth*.03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: screenwidth*.6,
                          child: Text(
                            loginmodel.message,
                            textAlign: TextAlign.center,
                            style: Utils.googlenunitoreg(14.0, Utils.lightgrey1)  ,
                          ),
                        ),
                        Utils.sizeBoxHeight(screenheight*.03),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: screenwidth*.01),
                          height: screenheight*.065,
                          child: PainCButton(
                            title: 'Reset Password',
                            onTap: (){
                              Get.back();
                              Get.to(()=>CreateNewPassword());
                            },
                            borderColor: Utils.bottleclr,
                            titleColor: Utils.bottleclr,
                            spashColor: Utils.bottleclr,
                            tappedTitleColor: Utils.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),/*RoundedBtn(
                        ontap: ontap,
                        btnclr: Utils.bottleclr,
                        btntxtclr: Utils.white,
                        txt: 'OK',
                      ),*/
                        ),
                        Utils.sizeBoxHeight(screenheight*.03),
                      ],
                    ),
                  ),
                ],
              ),
            )
        /*PopUp(ontap: (){
              Get.back();
              Get.to(()=>CreateNewPassword());},
              description: loginmodel.message,
            hastitle: false,)*/);

       // Utils.toast(loginmodel.message, '', Utils.red.withOpacity(0.5));
      }
      else {
        hideLoadingDialog(context: context);
        Utils.toast(loginmodel.message, '',
            Utils.red.withOpacity(0.5));
      }
    }
  }
  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
  Future<String>getToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    print('TOKENTOKEN $token');
    return token;
  }
  void clear() {
    usernameController.clear();
    passwordController.clear();
  }
}
