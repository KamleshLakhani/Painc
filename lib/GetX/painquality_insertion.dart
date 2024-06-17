import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:painc/ApiClass/ErrorClass.dart';
import 'package:painc/ApiClass/GetDescriptor.dart';
import 'package:painc/ApiClass/GetMedicine.dart';
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/ApiClass/userdescriptior.dart';
import 'package:painc/DashboardActivity/MedicationInsertionActivity.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/SharedPreference.dart';
import 'dart:convert';

import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PainQuality_Insertion extends GetxController {
  RxBool extra;
   RxMap<String, bool> tagmap = RxMap<String, bool>();
   RxMap<String, bool> usertagmap;
   RxString empt = 'No Dscriptors Found'.obs;
  RxList add = [].obs;
  RxList useradd = [].obs;
  RxInt index;
  //Future<GetFullDesc> getdata;
  RxList extl = [].obs;
  RxList userextl = [].obs;
  String data;
  List<String> ext = [];
  List<String> userext = [];
  var items;
  RxBool ind = false.obs;
  Map<String, dynamic> main = Map<String, dynamic>();
  Map<String, dynamic> usermain = Map<String, dynamic>();
  getCheckboxItems(context) async {
    add.clear();
      tagmap.forEach((key, value) {
        if (value == true) {
          add.add(key.toString());
        }
      });
    print(add);
    if(add.isBlank){
      Utils.toast('Not Selected', 'Please select one of the following pain descriptors or Choose NONE', Utils.red.withOpacity(.4));
    }else{
      showLoadingDialog(context: context);
    final tags = add.reduce((value, element) => value + ',' + element);
    print(tags);
    var jsonData = {'descriptor': tags.toString()};
    http.Response response =
        await ResponseClass.callPostApi(jsonData, ApiSheet.descriptor_save);
    print('GTGTGT ${response.statusCode}');
    print(response.body);
      MainError err = MainError.fromJson(json.decode(response.body));
    if (err.status) {
      hideLoadingDialog(context: context);
      Get.back();
      Get.to(() => MedicationInsertion());
      // Get.to(()=>Medication());
    } else{
      hideLoadingDialog(context: context);
      Utils.toast('', err.message, Utils.red.withOpacity(.3));
    }
  }}
  @override
  void onInit() async {
    getuserdesc();
    print('NULL $tagmap');
   /* http.Response response =
        await ResponseClass.callGetApi(ApiSheet.descriptor_get);
    if (response.statusCode == 200) {
      print('MAINKJLLIST $useradd');
      String responseString = response.body;
      GetFullDesc data = GetFullDesc.fromJson(json.decode(responseString));
      data.data.forEach((element){
        main['id'] = element.id;
        main['name'] = element.name;
        ext.add(main.toString());
        extl.add(element.name);
        tagmap = {for (var item in extl)
          '$item': useradd.contains(item) ? true : false}.obs;
      });
    }
    print(ext);
    print(extl);
    getdata = getdesciptor();*/
    super.onInit();
  }

  void insertioncontroller() async {
    // ext = (tagmap.keys.where((k) => tagmap[k] == true)).toList();
    // var jsonData = {"Painquallity" : ["DATA","DATA1"]};
    // print('HHHHHHHHHH');
    // http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.pain_quallity);
    // print(response.body);
    // print(response.statusCode);
    Get.back();
    Get.to(() => MedicationInsertion());
  }
   getuserdesc() async{
      http.Response response = await ResponseClass.callGetApi(ApiSheet.get_all_data);
      PainquallityUser usertags = PainquallityUser.fromJson(json.decode(response.body));
      if(usertags.status){
        print('user');
        if(usertags.data.painquallity.isNotEmpty){
          usertags.data.painquallity.forEach((element){
            print('DATADATA ${element.descriptor.name}');
            useradd.add(element.descriptor.name);
          });
        }
        print('USERLIST $useradd');
        http.Response response =
        await ResponseClass.callGetApi(ApiSheet.descriptor_get);
        if (response.statusCode == 200) {
          print('MAINKJLLIST $useradd');
          String responseString = response.body;
          GetFullDesc data = GetFullDesc.fromJson(json.decode(responseString));
          data.data.forEach((element){
            main['id'] = element.id;
            main['name'] = element.name;
            ext.add(main.toString());
            extl.add(element.name);
            tagmap = {for (var item in extl)
              '$item': useradd.contains(item) ? true : false}.obs;
          });

        }
        print(ext);
        print(extl);
        //getdata = getdesciptor();
      }else{
        print('no user');
      }
    }
   }
  /*Future<GetFullDesc> getdesciptor() async {
    http.Response response =
        await ResponseClass.callGetApi(ApiSheet.descriptor_get);
    if (response.statusCode == 200) {
      String responseString = response.body;
      print(responseString);
      print(response.statusCode);
      //GetFullDesc data = GetFullDesc.fromJson(json.decode(responseString));
      return GetFullDesc.fromJson(json.decode(responseString));
    } else {
      throw Exception('Failed');
    }
  }*/
RxList tags = [
  'Dull ache',
  'Throbbing',
  'Sharp',
  'Cramping',
  'Dull ache',
  'Throbbing',
  'Sharp',
  'Cramping',
  'Shooting',
  'Burning',
  'Dull ache',
  'Throbbing',
  'Sharp',
  'Cramping',
  'Shooting',
  'Burning',
  'Stabbing',
  'Pricking',
  'Stinging',
  'Unpleasant Tingling',
  'Itchy',
  'Intense',
  'Annoying',
  'Agonizing',
  'Electirc shock like',
  'Shooting',
  'Burning',
  'Stabbing',
].obs;
