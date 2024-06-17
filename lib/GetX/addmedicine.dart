import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:painc/ApiClass/AddMedicineError.dart';
import 'package:painc/ApiClass/medicinesearch.dart';
import 'package:painc/DashboardActivity/MedicationInsertionActivity.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/getpref.dart';
import 'package:painc/Utils/routes.dart';
import 'package:painc/components/loader.dart';
import 'package:painc/components/searchbox.dart';

class addmedicine extends GetxController{
  //String token = GetPref.getgs(GetPref.token);
  GlobalKey<AutoCompleteTextFieldState<String>> drugsearchkey = new GlobalKey();
  TextEditingController drugnamecontroller = TextEditingController();
  TextEditingController selectdose = TextEditingController();
  TextEditingController totaldose = TextEditingController();
  TextEditingController hourlydose = TextEditingController();
  int medicineid = 0;
  String selecteddose;
  List<Map<String,dynamic>> segs = [];
  List<String> seg = [];
  HashMap <String, dynamic> medicines  = HashMap<String,dynamic>();
  SearchMedicine search;
  List<String> ddvalue = [];
  List main = [];
  @override
  void onClose() {
    clear();
    super.onClose();
  }
  @override
  void onInit() async{
    http.Response response = await ResponseClass.callGetApi(ApiSheet.medicine);
    var responseString = response.body;
     search = SearchMedicine.fromJson(json.decode(responseString));
    print(response.statusCode);
    Map<String, dynamic> data = Map<String, dynamic>();
    seg.clear();
    main.clear();
    data.clear();
    for(var i=0; i<search.data.length; i++){
      var hasmap = HashMap();
      hasmap['id'] = search.data[i].id;
      hasmap['drug']= search.data[i].drug;
      hasmap['units'] = search.data[i].units;
      main.add(hasmap);
    }
    search.data.forEach((v){
      seg.add(v.drug);
    });
    super.onInit();
  }

/*  void insertmedicine(context) async{
    showLoadingDialog(context: context);
    var jsonData;
    print(search);
    print('SASASASASA $medicineid');
    print('DDDDDOOO $selecteddose');
    print('UDTRTRH ${selectdose.text}');
    if(hourlydose.text != ''){
      jsonData = {
        "medicine_id": medicineid,
        "doses": double .parse(hourlydose.text),
        //"tablets_per_day": hourlydose.text
      };
    }else{
      jsonData = {
        "medicine_id": medicineid,
        "doses": double.parse(selecteddose),
        "tablets_per_day": int.parse(selectdose.text)
      };
    }
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    print('SASASASASA ${medicineid.runtimeType}');
    print('DDDDDOOO ${double.parse(selecteddose).runtimeType}');
    print('UDTRTRH ${int.parse(selectdose.text).runtimeType}');
    final http.Request request = await http.Request('POST', Uri.parse(ApiSheet.addmedication));
    request.headers.addAll(headers);
    request.body = json.encode(jsonData);
    http.StreamedResponse response = await request.send();
    print('KJL ${response.statusCode}');
    if (response.statusCode == 200) {
      hideLoadingDialog(context: context);
      print(await response.stream.bytesToString());
      clear();
      Get.back();
    }else if(response.statusCode == 422){
      hideLoadingDialog(context: context);
      AddMedicineError err = AddMedicineError.fromJson(json.decode(request.body));
      if(drugnamecontroller.text.isEmpty){
        hideLoadingDialog(context: context);
        Utils.toast(err.message, err.error.medicineId.toString(), Utils.red.withOpacity(0.4));
      }else if(selectdose.isNull){
        hideLoadingDialog(context: context);
        Utils.toast(err.message, err.error.doses.toString(), Utils.red.withOpacity(0.4));
      }
      else{
        hideLoadingDialog(context: context);
        Utils.toast('Invalid Data', 'Enter Data', Utils.red.withOpacity(0.4));
      }
    }
    else{
      hideLoadingDialog(context: context);
      print(response.reasonPhrase);
    }
  }*/
  void insertmedicine(context) async{
    showLoadingDialog(context: context);
    if(drugnamecontroller.text.contains('None')){
      var jsonData = {
        "medicine_id": medicineid.toString(),
        "doses": '0',
      };
      http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.addmedication);
      print('NOW YOU ARE HERE');
      print(response.body);
      if (response.statusCode == 200) {
        hideLoadingDialog(context: context);
        clear();
        Get.back();
        update();
      }
    }else{
    var jsonData;
    print(search);
    print('SASASASASA $medicineid');
    print('DDDDDOOO $selecteddose');
    print('UDTRTRH ${selectdose.text}');
    if(hourlydose.text != ''){
      print('IN IF');
      jsonData = {
        "medicine_id": medicineid.toString(),
        "doses": hourlydose.text,
        //"tablets_per_day": hourlydose.text
      };
    }
    else{
      print('IN ELSE');
      jsonData = {
        "medicine_id": medicineid.toString(),
        "doses": selecteddose,
        "tablets_per_day": selectdose.text
      };
    }
    print('SASASASASA ${medicineid.runtimeType}');
    print('DDDDDOOO ${selecteddose.runtimeType}');
    print('UDTRTRH ${selectdose.text.runtimeType}');
    print('YOU ARE HERE');
    http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.addmedication);
    print('NOW YOU ARE HERE');
    if (response.statusCode == 200) {
      hideLoadingDialog(context: context);
      //print(await response.stream.bytesToString());
      clear();
      Get.back();
      update();
    }
    else if(response.statusCode == 422){
      hideLoadingDialog(context: context);
      AddMedicineError err = AddMedicineError.fromJson(json.decode(response.body));
      if(drugnamecontroller.text.isEmpty){
        hideLoadingDialog(context: context);
        Utils.toast(err.message, err.error.medicineId.toString(), Utils.red.withOpacity(0.4));
      }else if(selectdose.isNull){
        hideLoadingDialog(context: context);
        Utils.toast(err.message, err.error.doses.toString(), Utils.red.withOpacity(0.4));
      }
      else{
        hideLoadingDialog(context: context);
        Utils.toast('Invalid Data', 'Enter Data', Utils.red.withOpacity(0.4));
      }
    }
    else{
      hideLoadingDialog(context: context);
      print(response.reasonPhrase);
    }
  }}
  void dropget(data){
    for(var i =0; i< search.data.length; i++){
      List<String> unitss = [];
      List fetched = [];
      if(search.data[i].drug == data){
        medicineid = search.data[i].id;
        fetched = search.data[i].units;
        fetched.forEach((element) {
               unitss.add(element.toString());
             });
        ddvalue = unitss;
      }else{
        print('no dadadada');
      }
    }
    print(ddvalue);
  }
  void clear(){
    drugnamecontroller.clear();
    totaldose.clear();
    selectdose.clear();
    hourlydose.text = '';
    ddvalue = [];
    selecteddose = null;
  }
}
/*List<String> suggestions = [
  "Apple", "Armidillo", "Actual", "Actuary", "America", "Argentina", "Australia", "Antarctica", "Blueberry", "Cheese", "Danish", "Eclair", "Fudge", "Granola", "Hazelnut", "Ice Cream", "Jely", "Kiwi Fruit", "Lamb", "Macadamia", "Nachos", "Oatmeal", "Palm Oil", "Quail", "Rabbit", "Salad", "T-Bone Steak", "Urid Dal", "Vanilla", "Waffles", "Yam", "Zest"
];*/
