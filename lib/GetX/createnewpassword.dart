/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';

class createnewpass extends GetxController{

  @override
  void onClose() {
    varificationcodeController.dispose();
    newpassController.dispose();
    confirmpassController.dispose();
    super.onClose();
  }
  void crtpss() async{
    if(createpass.currentState.validate()){
      var jsonData={
        'varificationcode':varificationcodeController.text.trim(),
        'newpassword': newpassController.text.trim(),
        'confirmpassword':confirmpassController.text.trim()
      };
      http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.resetpasswordsendotp);
      var responseString = response.body;
      print('validated');
    }
  }
}*/
