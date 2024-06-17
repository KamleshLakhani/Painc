import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:painc/ApiClass/GetTreatmentClass.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
class TreatmentCon extends GetxController{
  Future<GetTreatment> getdata;
  @override
  void onInit() {
    print('in in it');
    getdata = getmed();
    super.onInit();
  }
  Future<GetTreatment> getmed() async{
    print('req not send');
    http.Response response = await ResponseClass.callGetApi(ApiSheet.treatment_get);
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      return GetTreatment.fromJson(json.decode(response.body));
    }
  }
}