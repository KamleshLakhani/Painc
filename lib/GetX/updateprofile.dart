import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:painc/Utils/getpref.dart';
import 'package:painc/Utils/routes.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/loader.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:painc/ApiClass/CurrentUser.dart';
import 'package:painc/ApiClass/UpdateProfile.dart';
import 'package:painc/ApiClass/login.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:http/http.dart' as http;
import 'package:painc/Utils/SharedPreference.dart';
import 'package:painc/Utils/Utils.dart';

class UpdateController extends GetxController{
  RxBool showloader = false.obs;
  File imagefile;
  GlobalKey<FormState> updateprofile = GlobalKey<FormState>(debugLabel: 'signupform');
  TextEditingController fnameController = TextEditingController();
  TextEditingController mnameController  = TextEditingController();
  TextEditingController snameController  = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  RxString profileimg = ''.obs;
  // RxString saveddate = ''.obs;
  //   // RxString gender = ''.obs;
  //   // RxString dob = ''.obs;
  //   //DateTime selectedDate = DateTime.now();
  DateTime selectedDate;
  RxString date = ''.obs;
  LoginModel loginmodel = new LoginModel();
  CurrentUser usermodel;
  RxString choosenvalue;
  RxString hint = ''.obs;
  var datata;

  @override
  void onInit() async{
    showloader = true.obs;
    http.Response response = await ResponseClass.callGetApi(ApiSheet.currentuserinfo);
    usermodel = CurrentUser.fromJson(json.decode(response.body));
    if(usermodel.status){
      showloader = false.obs;
      update();
      print(usermodel.data.profileImage);
      datata = DateTime.parse(usermodel.data.dob);
      selectedDate = datata;
      print('HIHIHIHI $hint');
      print('LOADER $showloader');
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(datata);
      profileimg = usermodel.data.profileImage.obs;
      fnameController.text = usermodel.data.firstName;
      mnameController.text = usermodel.data.lastName;
      snameController.text = usermodel.data.surname;
      hint = usermodel.data.gender.obs;
      dateController.text = formatted;
      addressController.text = usermodel.data.address;
      pincodeController.text = usermodel.data.postcode;
    }
    super.onInit();
  }
  @override
  void onClose() {
    fnameController.dispose();
    mnameController.dispose();
    snameController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    dateController.dispose();
    super.onClose();
  }
  void updateprofiledata(context) async{
    print('CHOOSED VALUE $choosenvalue');
    print('CHOOSED VALUE ${usermodel.data.gender}');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(datata);
    if(updateprofile.currentState.validate()){
      showLoadingDialog(context: context);
      var jsonData={
        'first_name': fnameController.text.toString().trim(),
        'last_name': mnameController.text.toString().trim(),
        'surname' : snameController.text.toString().trim(),
        'gender':choosenvalue == null ? hint.toString() : choosenvalue.toString(),
        'dob': date.toString() == '' ? formatted.toString() : date.toString(),
        'address':addressController.text.toString().trim(),
        'postcode':pincodeController.text.toString().trim(),
      };
      if(imagefile == null){
        if(fnameController.text == usermodel.data.firstName &&
            mnameController.text == usermodel.data.lastName &&
            snameController.text == usermodel.data.surname &&
            hint == usermodel.data.gender.obs &&
            dateController.text == formatted &&
            addressController.text == usermodel.data.address &&
            pincodeController.text == usermodel.data.postcode){
          print('inif');
          Utils.toast('You haven\'t updated anything', '', Utils.red.withOpacity(.4));
        }else{
        http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.updateprofile);
        print(response.body);
        print(response.statusCode);
        print(hint);
        if(response.statusCode == 200){
          hideLoadingDialog(context: context);
          showDialog(context: context, builder: (context) =>
          PopUp(ontap: () async{
            http.Response res = await ResponseClass.callGetApi(ApiSheet.currentuserinfo);
            CurrentUser newusermodel = CurrentUser.fromJson(json.decode(res.body));
            Constant.profilepic = newusermodel.data.profileImage;
            Constant.name = '${fnameController.text.toString().trim()} ${snameController.text.toString().trim()}';
        /*    UpdateSucc updated = UpdateSucc.fromJson(json.decode(response.body));
            Constant.name = '${fnameController.text.toString().trim()} ${snameController.text.toString().trim()}';
            Utils.toast('',updated.message, Utils.white.withOpacity(0.5));*/
            Get.offAllNamed(Routes.dashboard);
          },title: 'Profile Updated',description: '',hastitle: true,));
        }
        else{
          hideLoadingDialog(context: context);
          UpdateFail notupdated = UpdateFail.fromJson(json.decode(response.body));
          Utils.toast(notupdated.message, notupdated.error.toString(), Utils.white.withOpacity(0.5));
        }
        }
      }
      else{
        var multipartFile = http.MultipartFile.fromBytes(
          'profile_image', (imagefile.readAsBytesSync()),
          filename: 'anatomy.jpg', // use the real name if available, or omit
        );
        var request = await ResponseClass.callMultipartpost(multipartFile, jsonData, ApiSheet.updateprofile);
        http.StreamedResponse response = await request.send();
        var responseData = await response.stream.toBytes();
        var responsestring = String.fromCharCodes(responseData);
        if (response.statusCode == 200) {
          hideLoadingDialog(context: context);
          showDialog(context: context, builder: (context) =>
              PopUp(ontap: () async{
                http.Response res = await ResponseClass.callGetApi(ApiSheet.currentuserinfo);
                CurrentUser newusermodel = CurrentUser.fromJson(json.decode(res.body));
                Constant.profilepic = newusermodel.data.profileImage;
                Constant.name = '${fnameController.text.toString().trim()} ${snameController.text.toString().trim()}';
                Get.offAllNamed(Routes.dashboard);
              },
                title: 'Your Profile Has Been Updated',description: '',hastitle: true,));
        }
        else if(response.statusCode == 422){
          hideLoadingDialog(context: context);
          print(response.reasonPhrase);
          UpdateFail notupdated = UpdateFail.fromJson(json.decode(responsestring));
          Utils.toast(notupdated.message, notupdated.error.toString(), Utils.white.withOpacity(0.5));
        }
      }
    }
  }
  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1980),
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
                        Navigator.of(context).pop(tempPickedDate);
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
                    maximumYear: DateTime.now().year,
                    mode: CupertinoDatePickerMode.date,
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
}