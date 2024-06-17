import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:painc/ApiClass/PainIntensity.dart';
import 'package:painc/DashboardActivity/PainQualityInsertionActivity.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/getpref.dart';
import 'package:http/http.dart' as http;
import 'package:painc/Utils/loader.dart';
import 'package:painc/Utils/routes.dart';
import 'package:painc/screens/Dashboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
class getfutureinfo extends GetxController{
  RxString piqoldata;
  String desc ;
  //String token = GetPref.getgs(GetPref.token);
  void insertdata(context, secondtime) async{
    showLoadingDialog(context: context,barrierColor: Utils.lightgrey2.withOpacity(.2));
    var jsonData={'description' : desc.toString(),};
    http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.furtherinfo);
    var resposeString = response.body;
    print(resposeString);
    print(response.statusCode);
    PainIntensity _intensitymodel =  PainIntensity.fromJson(json.decode(resposeString));
    if(_intensitymodel.status){
      final _pdf = await ResponseClass.callGetApi(ApiSheet.baselinereportdownload);
      if(_pdf.statusCode == 200){
        if(secondtime == true){
          hideLoadingDialog(context: context);
          Get.offAndToNamed(Routes.dashboard);
        }else{
          hideLoadingDialog(context: context);
          Get.offAndToNamed(Routes.dashboard);
          String dir = (await getApplicationDocumentsDirectory()).path;
          File file = new File('$dir/Report.pdf');
          final _saved = await file.writeAsBytes(_pdf.bodyBytes);
          print(_saved.path);
          // hideLoadingDialog(context: context);
         // Get.back();
          OpenFile.open(_saved.path);
        }
      }
    }else{
      Utils.toast(_intensitymodel.message, _intensitymodel.message, Utils.red.withOpacity(.4));
    }
  }
}