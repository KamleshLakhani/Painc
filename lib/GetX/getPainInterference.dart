import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/ApiClass/PainIntensity.dart';
import 'package:painc/DashboardActivity/PainQualityInsertionActivity.dart';
import 'package:painc/DashboardActivity/QoLInsertionActivity.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/getpref.dart';
import 'package:painc/components/loader.dart';
import 'package:painc/screens/Dashboard.dart';

class getPainInterference extends GetxController {
  RxString pidata;
  double genrallife;
  double enjoylife;
  double thermval;
  //String token = GetPref.getgs(GetPref.token);
  void insertdata(context) async {
    showLoadingDialog(context: context);
    http.Response res = await ResponseClass.callGetApi(ApiSheet.get_all_data);
    InsertionStatus data = InsertionStatus.fromJson(json.decode(res.body));
    thermval = data.data.qualityoflife == null || data.data.qualityoflife.helth_thermometer == "null" ? 0.0 :double.parse(data.data.qualityoflife.helth_thermometer);
    print('TTTTT $thermval');
    print('fffff ${genrallife}');
    print('fffff ${enjoylife}');
    var jsonData = {
      'enjoyment_life': genrallife.toString(),
      'general_activity': enjoylife.toString(),
    };
    http.Response response =
        await ResponseClass.callPostApi(jsonData, ApiSheet.getpaininterference);
    var resposeString = response.body;
    print(resposeString);
    print(response.statusCode);
    PainIntensity _intensitymodel =
        PainIntensity.fromJson(json.decode(resposeString));
    if (_intensitymodel.status) {
      hideLoadingDialog(context: context);
      Get.back();
      Get.to(QoLInsertion(thermvalue: thermval));
    } else {
      hideLoadingDialog(context: context);
      // PainIntensityError _intensityerrmodel =  PainIntensityError.fromJson(json.decode(resposeString));
      Utils.toast(_intensitymodel.message, _intensitymodel.message, Utils.red.withOpacity(.4));
    }
  }
}
