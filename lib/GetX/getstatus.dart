import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
class StatusController extends GetxController{
  Future<InsertionStatus> status;
  @override
  void onInit() {
    status = getstatus();
    super.onInit();
  }
  Future<InsertionStatus> getstatus() async{
    http.Response response = await ResponseClass.callGetApi(ApiSheet.get_all_data);
    print(response.statusCode);
    print(response.body);
    InsertionStatus data = InsertionStatus.fromJson(json.decode(response.body));
    if(data.status){
      return InsertionStatus.fromJson(json.decode(response.body));
    }
  }
}