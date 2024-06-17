import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/UpdateProfile.dart';
import 'package:painc/ApiClass/otp.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/routes.dart';
import 'package:painc/components/loader.dart';
import 'package:painc/screens/CreateNewPasswordActivity.dart';
import 'package:http/http.dart' as http;

class fp extends GetxController{
  GlobalKey<FormState> fpform = GlobalKey<FormState>(debugLabel: 'fpform');
  GlobalKey<FormState> createpass = GlobalKey<FormState>(debugLabel: 'createpass');
  TextEditingController emailController = TextEditingController();
  TextEditingController varificationcodeController = TextEditingController();
  TextEditingController newpassController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
  void forgotpass(context) async{
    if(fpform.currentState.validate()){
      showLoadingDialog(context: context);
      var jsonData = {'email': emailController.text.trim()};
      http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.resetpasswordsendotp);
      var responseString = response.body;
      print('RES $responseString');
      print(response.statusCode);
      OtpSuccess otpdata = OtpSuccess.fromJson(json.decode(responseString));
      if(otpdata.status){
        hideLoadingDialog(context: context);
          Get.offAndToNamed(Routes.createnewpassword);
        Utils.toast('',otpdata.message, Utils.green);
        //Get.to(CreateNewPassword());
      }else if(response.statusCode == 200){
        hideLoadingDialog(context: context);
        Utils.toast('',otpdata.message, Utils.red.withOpacity(0.5));
      }
      else{
        hideLoadingDialog(context: context);
        OtpFailed otpfaileddata = OtpFailed.fromJson(json.decode(responseString));
        Utils.toast(otpfaileddata.message,otpfaileddata.error.email.toString(), Utils.red.withOpacity(0.5));
      }
    }else{
      print('validated');
    }
  }
  void crtpss(context) async{
    if(createpass.currentState.validate()){
      showLoadingDialog(context: context);
      var jsonData={
        'email': Constant.email == '' ?emailController.text.trim() : Constant.email,
        'otp': varificationcodeController.text.trim(),
        'password': newpassController.text.trim(),
        'password_confirmation':confirmpassController.text.trim()
      };
      http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.resetpassword);
      var responseString = response.body;
      print(response.statusCode);
      if(response.statusCode == 200){
        hideLoadingDialog(context: context);
        ValidOtp validOtp = ValidOtp.fromJson(json.decode(responseString));
        Get.back();
        Constant.email = '';
       Utils.toast('', validOtp.message, Utils.green);
      }else{
        InvalidOtp invalidOtp = InvalidOtp.fromJson(json.decode(responseString));
     if(invalidOtp.error.otp!=null){
       hideLoadingDialog(context: context);
      Utils.toast(invalidOtp.message, invalidOtp.error.otp.toString(), Utils.red.withOpacity(.5));
    }
    else if(invalidOtp.error.password!=null){
       hideLoadingDialog(context: context);
      Utils.toast(invalidOtp.message, invalidOtp.error.password.toString(), Utils.red.withOpacity(.5));
    }
    else if(invalidOtp.error.email!=null){
       hideLoadingDialog(context: context);
      Utils.toast(invalidOtp.message, invalidOtp.error.email.toString(), Utils.red.withOpacity(.5));
    }
      }
    }
  }
}
class OtpSuccess {
  bool status;
  String message;

  OtpSuccess({this.status, this.message});

  OtpSuccess.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
class OtpFailed {
  bool status;
  String message;
  Error error;

  OtpFailed({this.status, this.message, this.error});

  OtpFailed.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}
class Error {
  List<String> email;

  Error({this.email});

  Error.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}
