import 'dart:convert';

import 'package:get/get.dart';
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/ApiClass/PainIntensity.dart';
import 'package:painc/DashboardActivity/FurtherInformationInsertionActivity.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/getpref.dart';
import 'package:http/http.dart' as http;
import 'package:painc/Utils/loader.dart';

class getQulityoflife extends GetxController {
  RxString piqoldata;
  double valuqol;
  double enjoylife;
  //String token = GetPref.getgs(GetPref.token);
  void insertdata(context) async {
    showLoadingDialog(context: context);
    var jsonData = {
      'helth_thermometer': valuqol.toString(),
    };
    http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.qualityoflife);
    var resposeString = response.body;
    print(resposeString);
    print(response.statusCode);
    PainIntensity _intensitymodel = PainIntensity.fromJson(json.decode(resposeString));
    var filled = false;
    var allstepfilled = false;
    http.Response res = await ResponseClass.callGetApi(ApiSheet.get_all_data);
    InsertionStatus data = InsertionStatus.fromJson(json.decode(res.body));
    if(data.baseline_status == true){
      filled = true;
      update();
    }
    if(data.data.painlocation != null && data.data.painintensity != null && data.data.painquallity != [] && data.data.medication != [] &&
        data.data.treatments != null && data.data.paininterferences != null && data.data.qualityoflife != null){
      allstepfilled = true;
      update();
    }
    print(filled);
    print('fffff ${valuqol}');
    if (_intensitymodel.status) {
      hideLoadingDialog(context: context);
      Get.back();
      //if(filled == false){
        Get.to(FurtherInformationInsertion(
          tnc: Constant.tnc,
          secondtime: filled == true ? true : false,allstepfilled: allstepfilled,));
      //};
    } else {
      hideLoadingDialog(context: context);
      // PainIntensityError _intensityerrmodel =  PainIntensityError.fromJson(json.decode(resposeString));
      Utils.toast(_intensitymodel.message, _intensitymodel.message, Utils.red);
    }
  }
}
