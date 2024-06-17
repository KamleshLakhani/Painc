import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/ApiClass/PainIntensity.dart';
import 'package:painc/DashboardActivity/MedicationInsertionActivity.dart';
import 'package:painc/DashboardActivity/PainQualityInsertionActivity.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/getpref.dart';
import 'package:painc/components/loader.dart';
class PainIntensity_Insertion extends GetxController{
RxString pidata;
double value;

void insertdata(context) async{
  showLoadingDialog(context: context);
  var filled = false;
  http.Response res = await ResponseClass.callGetApi(ApiSheet.get_all_data);
  InsertionStatus data = InsertionStatus.fromJson(json.decode(res.body));
  if(data.baseline_status == true){
    filled = true;
    update();
  }
  print(filled);
  var jsonData={
    'pain_intensity' : value.toString()
  };
  http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.pain_intensity);
  var resposeString = response.body;
  print(resposeString);
  print(response.statusCode);
  if(response.statusCode == 200){
    hideLoadingDialog(context: context);
    PainIntensity _intensitymodel =  PainIntensity.fromJson(json.decode(resposeString));
    Get.back();
    filled == false ? Get.to(()=>PainQualityInsertion()) : Get.to(()=>MedicationInsertion());
  }else{
    hideLoadingDialog(context: context);
    PainIntensityError _intensityerrmodel =  PainIntensityError.fromJson(json.decode(resposeString));
    Utils.toast(_intensityerrmodel.message, _intensityerrmodel.error.painIntensity.toString(), Utils.red);
  }
}
}