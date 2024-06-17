import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:painc/ApiClass/RegError.dart';
import 'package:painc/ApiClass/registration.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:painc/Utils/routes.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/loader.dart';
import 'package:painc/screens/AllTnC.dart';

class RegisterController extends GetxController{
  GlobalKey<FormState> signupform = GlobalKey<FormState>(debugLabel: 'signupform');
   TextEditingController fnameController = TextEditingController();
   TextEditingController mnameController = TextEditingController();
   TextEditingController snameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  RxString saveddate = ''.obs;
  RxString gender = ''.obs;
  RxString dob = ''.obs;
  DateTime selectedDate = DateTime.now();
  RxBool gdpr = false.obs;
  RxBool agree = false.obs;
  RxString date =''.obs;
  @override
  void onClose() {
    fnameController.dispose();
    mnameController.dispose();
    snameController.dispose();
    emailController.dispose();
    pincodeController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    dateController.dispose();
  }
  Future signup(context) async{
    String deviceId = await _getId();
    showLoadingDialog(context: context);
    print('KJKJK ${gender.trim()}');
    var jsonData ={
      'first_name': fnameController.text.trim(),
      'last_name': mnameController.text.trim(),
      'surname' : snameController.text.trim(),
      'email':emailController.text.trim(),
      'gender':gender.trim(),
      'dob':date.trim(),
      'address':addressController.text,
      'postcode':pincodeController.text.trim(),
      'password':passwordController.text.trim(),
      'password_confirmation':confirmpasswordController.text.trim(),
      'device_id' : deviceId.trim(),
    };
    print(jsonData);
    http.Response response = await ResponseClass.callPostApi(jsonData,ApiSheet.register);
    String responseString = response.body;
    print(response.body);
    print(gender);
    if(response.statusCode == 200){
      hideLoadingDialog(context: context);
      RegSuccess regsuc = RegSuccess.fromJson(json.decode(responseString));
      Get.back();
      showDialog(context: context, builder: (context) {
        return PopUp(
          hastitle: true,
          title: regsuc.message,
          description:regsuc.info,
          ontap: () {
            // Get.offAndToNamed(Routes.login);
            Get.back();
            Get.back();
          },
        );
      });
    }
    if(response.statusCode == 422){
      print(responseString);
      hideLoadingDialog(context: context);
      RegError regError = RegError.fromJson(json.decode(responseString));
      if(regError.error.email != null){
        Get.back();
        Utils.toast(regError.message, '${regError.error.email.toString()}',  Utils.red.withOpacity(0.5));
      }if(regError.error.password != null){
        Get.back();
        Utils.toast(regError.message, '${regError.error.password.toString()}', Utils.red.withOpacity(0.5));
      }if(regError.error.password != null && regError.error.email != null){
        Get.back();
        Utils.toast(regError.message, '${regError.error.email.toString()} and ${regError.error.password.toString()}', Utils.red.withOpacity(0.5));
      }
    }
   /* if(signupform.currentState.validate()){
      String deviceId = await _getId();
      showLoadingDialog(context: context);
      print('KJKJK ${gender.trim()}');
      var jsonData ={
        'first_name': fnameController.text.trim(),
        'last_name': mnameController.text.trim(),
        'surname' : snameController.text.trim(),
        'email':emailController.text.trim(),
        'gender':gender.trim(),
        'dob':date.trim(),
        'address':addressController.text,
        'postcode':pincodeController.text.trim(),
        'password':passwordController.text.trim(),
        'password_confirmation':confirmpasswordController.text.trim(),
        'device_id' : deviceId.trim(),
      };
      print(jsonData);
      http.Response response = await ResponseClass.callPostApi(jsonData,ApiSheet.register);
      String responseString = response.body;
      print(response.body);
      print(gender);
      if(response.statusCode == 200){
        hideLoadingDialog(context: context);
        RegSuccess regsuc = RegSuccess.fromJson(json.decode(responseString));
        showDialog(context: context, builder: (context) {
          return PopUp(
            hastitle: true,
            title: regsuc.message,
            description:regsuc.info,
            ontap: () {
              // Get.offAndToNamed(Routes.login);
              Get.back();
              Get.back();
              },
          );
        });
      }
      if(response.statusCode == 422){
        print(responseString);
        hideLoadingDialog(context: context);
        RegError regError = RegError.fromJson(json.decode(responseString));
        if(regError.error.email != null){
          Utils.toast(regError.message, '${regError.error.email.toString()}',  Utils.red.withOpacity(0.5));
        }if(regError.error.password != null){
          Utils.toast(regError.message, '${regError.error.password.toString()}', Utils.red.withOpacity(0.5));
        }if(regError.error.password != null && regError.error.email != null){
          Utils.toast(regError.message, '${regError.error.email.toString()} and ${regError.error.password.toString()}', Utils.red.withOpacity(0.5));
        }
      }
    }*/
  }
  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null)
        selectedDate = picked;
        dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
        date = DateFormat('yyyy-MM-dd').format(selectedDate).obs;
  }
  Future<Null> selectIOSDate(BuildContext context) async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        var nd = DateTime.now().difference(tempPickedDate== null ? DateTime.now() :tempPickedDate).inHours;
                        if(nd < 0){
                          Utils.toast('Birthdate can not be in future', '', Utils.red.withOpacity(.4));
                        }else{
                          var newtempPickedDate = tempPickedDate == null ? DateTime.now() : tempPickedDate;
                          Navigator.of(context).pop(newtempPickedDate);
                        }
                       // Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                   maximumYear: DateTime.now().year,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (pickedDate != null && pickedDate != selectedDate) {
        selectedDate = pickedDate;
        dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
        date = DateFormat('yyyy-MM-dd').format(selectedDate).obs;
    }
  }
  void gdrp(val) async{
    gdpr.toggle();
  }
  void accept(val) {
    agree.toggle();
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
}