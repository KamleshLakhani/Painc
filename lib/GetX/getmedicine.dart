import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:painc/ApiClass/GetMedicine.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
class getedicinecontroller extends GetxController{
  Future<GetMedicine> getdata;
  RxInt mlength;
  @override
  void onInit() {
    getdata = getmedicine();
    super.onInit();
  }
void fetchdata(){
}
  Future<GetMedicine> getmedicine() async{
    http.Response response = await ResponseClass.callGetApi(ApiSheet.getmedication);
    String responseString = response.body;
    if(response.statusCode == 200){
      print(response.body);
      GetMedicine getmd = GetMedicine.fromJson(json.decode(responseString));
      mlength = getmd.medication.length.obs;
      return GetMedicine.fromJson(json.decode(responseString));
    }else{
     throw Exception('Failed');
    }
  }
  void delete(int id) async{
    http.Response response = await ResponseClass.deleteAlbum(id,ApiSheet.medications_delete);
  }
}