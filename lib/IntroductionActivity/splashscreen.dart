import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/CurrentUser.dart';
import 'package:painc/ApiClass/login.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/SharedPreference.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:painc/Utils/getpref.dart';
import 'package:painc/screens/Dashboard.dart';
import 'package:painc/screens/LoginActivity.dart';
import 'GetStartedActivity.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String devicetoken;
  String logindata;
  @override
  void initState() {
    //String token = GetPref.getgs(GetPref.token);
    bool fgr = GetPref.getboolgs(GetPref.fingerdata);
    logindata = GetPref.getgs(GetPref.loginData);
    if(logindata != null){
      LoginModel login = LoginModel.fromJson(json.decode(logindata));
      // print('DEVICE ID ID ID ${login.user.device_id}');
      Constant.token =  login.token;
      Constant.name =  '${login.user.firstName} ${login.user.surname}';
      Constant.profilepic =  login.user.profileImage;
      Constant.email =  login.user.email;
    }
    update();
    super.initState();
    print(Constant.token);
    Timer(
        Duration(seconds: 2),
            () => Get.offAll(()=>
            Constant.token == '' && devicetoken != '' ? Login() :Constant.token != '' ? fgr == true ? Login() : Dashboard() : GetStarted() ));
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        body: Container(
      color: Utils.black,
      width: screenwidth,
      height: screenheight,
      child: (orientation == Orientation.portrait) ?
      Stack(
        fit: StackFit.expand,
        children: [
          Positioned(bottom:-screenheight*.02,right: -screenwidth*.4,left: -screenwidth*.37,height:screenheight*.75,
              child: Container(decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/svg/doc.png',),
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.hardLight),
                )
              ),)),
          Image.asset('assets/svg/grd.png',fit: BoxFit.cover,),
          SvgPicture.asset('assets/svg/shape1.svg',alignment: Alignment.topCenter,fit: BoxFit.fitWidth),
          SvgPicture.asset('assets/svg/shape2.svg',alignment: Alignment.bottomCenter,fit: BoxFit.fitWidth),
          SvgPicture.asset('assets/svg/whitelogo.svg',fit: BoxFit.scaleDown),
        ],
      )
      //Utils.imageAssets('assets/12.png', screenwidth, screenheight)
               : Utils.imageAssets('assets/splash-hor.png', screenwidth, screenheight)
    ));
  }
  update() async{
    if(logindata != null){
      print('requesting');
      http.Response response = await ResponseClass.callGetApi(ApiSheet.currentuserinfo);
      print('requested');
      CurrentUser usermodel = CurrentUser.fromJson(json.decode(response.body));
      Constant.name =  '${usermodel.data.firstName} ${usermodel.data.surname}';
      Constant.profilepic =  usermodel.data.profileImage;
      Constant.freshuser = usermodel.data.fresh_login;
    }
   devicetoken = await SharedPreference.getStringValuesSF(SharedPreference.deviceToken);
    print('DEVICETOKENTOKEN $devicetoken');
  }
}
