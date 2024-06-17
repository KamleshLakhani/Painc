import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:painc/ApiClass/ChangePassword.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'dart:convert';

import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/routes.dart';
import 'package:painc/components/loader.dart';
class CPController extends GetxController{
  TextEditingController oldpass = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  GlobalKey<FormState> cpform = GlobalKey<FormState>(debugLabel: 'loginform');
  void change(context) async{
    if(cpform.currentState.validate()){
      showLoadingDialog(context: context);
      var jsonData = {
        "old_password": oldpass.text,
        "password": password.text,
        "password_confirmation": confirmpass.text
      };
      http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.changepassword);
      ChangePasswordClass cp = ChangePasswordClass.fromJson(json.decode(response.body));
      print(response.statusCode);
      if(cp.status){
        hideLoadingDialog(context: context);
        Get.offAllNamed(Routes.dashboard);
        Utils.toast('Password Changed Successfully', '', Utils.green);
      }else{
        hideLoadingDialog(context: context);
        Utils.toast('Failed', cp.data.message, Utils.red.withOpacity(.4));
      }
    }
  }
}