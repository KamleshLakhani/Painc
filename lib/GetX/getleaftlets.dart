import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:painc/ApiClass/AddMedicineError.dart';
import 'package:painc/ApiClass/Getleaftlets.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/getpref.dart';
import 'package:painc/components/searchbox.dart';

class getleaftlets extends GetxController {
  Future<Getleaftlets> getdata;
  RxInt sizegetleaftlets = 0.obs;
  List<Data> titlegetleaftlets = List<Data>().obs;

  @override
  void onInit() async {
    getfutureleaftlets();
    super.onInit();
  }

  void getfutureleaftlets() async {
    http.Response response =
        await ResponseClass.callGetApi(ApiSheet.getleaftlets);
    var responseString = response.body;
    print(responseString);
    if (response.statusCode == 200) {
      Getleaftlets getleaftlets =
          Getleaftlets.fromJson(json.decode(responseString));
      if (getleaftlets.status) {
        titlegetleaftlets.addAll(getleaftlets.data);
      }
    } else {
      throw Exception('Failed');
    }
  }
}
